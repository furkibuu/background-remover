require "sinatra"
require "mini_magick"
require "securerandom"
require "net/http"
require "json"
require "net/http/post/multipart"

set :public_folder, File.join(__dir__, "public")
set :static, true
set :root, __dir__
set :data_folder, File.join(settings.public_folder, "data")
set :views, File.join(__dir__, "views")

REMOVE_BG_API_KEY = "API_KEY"


MiniMagick.configure do |config|
  config.tmpdir = File.join(__dir__, "public", "tmp")
end


Dir.mkdir(settings.public_folder) unless Dir.exist?(settings.public_folder)
Dir.mkdir(settings.data_folder) unless Dir.exist?(settings.data_folder)
Dir.mkdir(File.join(__dir__, "public", "tmp")) unless Dir.exist?(File.join(__dir__, "public", "tmp"))

get "/" do
  erb :index
end

post "/upload" do
  unless params[:file] && params[:file][:tempfile]
    halt 400, "❌ Dosya yüklenmedi!"
  end

  filename = "#{SecureRandom.hex(6)}_#{File.basename(params[:file][:filename])}"
  save_path = File.join(settings.data_folder, filename)

 
  File.open(save_path, "wb") { |f| f.write(params[:file][:tempfile].read) }
  image = MiniMagick::Image.open(save_path)

  begin
    case params[:action]
    when "resize"
      image.resize "800x800"
      image.write save_path

    when "remove_bg"
      uri = URI("https://api.remove.bg/v1.0/removebg")
      req = Net::HTTP::Post::Multipart.new(
        uri.path,
        "image_file" => UploadIO.new(File.open(save_path), "image/png", filename),
        "size" => "auto"
      )
      req["X-Api-Key"] = REMOVE_BG_API_KEY
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }

      if res.code.to_i == 200
        File.open(save_path, "wb") { |f| f.write(res.body) }
      else
        halt 500, "❌ Remove.bg hata: #{res.body}"
      end

    when "convert_jpg"
      new_path = save_path.sub(File.extname(save_path), ".jpg")
      image.format("jpg") { |img| img.quality "90" }
      image.write(new_path)
      save_path = new_path

    when "convert_png"
      new_path = save_path.sub(File.extname(save_path), ".png")
      image.format("png")
      image.write(new_path)
      save_path = new_path

    else
      halt 400, "❌ Geçersiz işlem türü!"
    end
  rescue => e
    halt 500, "❌ İşlem sırasında hata oluştu: #{e.message}"
  end

  @download_link = "/data/" + File.basename(save_path)
  erb :success
end

