$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))

require "gdownload"

class Gdownload < Thor

  desc "download LABEL", "download all attachments from labeled emails from your Gmail account."
  method_option :user,      :type => :string, :aliases => "-u", :required => true
  method_option :password,  :type => :string, :aliases => "-p", :required => true
  method_option :after,     :type => :string, :aliases => "-a"
  def download(label)
    after = Date.parse(options.after) unless options.after.nil?
    downloader = GmailAttachmentDownloader.new(options.user, options.password)
    downloader.download_attachments(label, :after => after)
  end
end
