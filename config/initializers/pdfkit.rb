PDFKit.configure do |config|
	config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
#    config.default_options[:ignore_load_errors] = true
    config.default_options[:quiet] = false

#    config.default_options = {
 #   :header_right => "Page [page] of [toPage]",
 # }
end
