require "gmail"
require "gdownload/file_name"

class GmailAttachmentDownloader < Struct.new(:account, :password)
  include FileName

  def download_attachments(label, options = {})
    normalize_options(options)
    Gmail.new(account, password) do |gmail|
      mailbox = gmail.label(label)
      puts "You have selected #{mailbox.count(options)} emails tagged with #{label.inspect}."
      download_attachments_from_mailbox(mailbox, options)
    end
  end

  private

  def normalize_options(options)
    @download_dir = options[:download] || "download"
    Dir.mkdir(@download_dir) unless Dir.exists?(@download_dir)
    [:before, :after].each do |datetime|
      options[datetime] = Date.parse(options[datetime]) if options[datetime].is_a?(String)
    end
  end

  def download_attachments_from_mailbox(mailbox, options)
    mailbox.emails(options).each_with_index do |email, i|
      puts "  [#{i + 1}] #{email.subject.inspect} (#{email.date}) [#{email.attachments.length} attachment(s)]"
      email.attachments.each do |attachment|
        save_attachment(attachment, :date => email.date.to_time)
      end
    end
  end

  def save_attachment(attachment, options = {})
    filename = File.join(@download_dir, attachment.filename)
    filename = unique_name_for(filename)
    File.open(filename, "w") do |file|
      file.write(attachment.decoded)
    end
    if options[:date]
      touch = options[:date].strftime("%Y%m%d%H%M.%S")
      %x(touch -t #{touch} #{filename})
    end
    # File.utime(options[:date], options[:date], filename) if options[:date]
    puts "    * saved #{filename}"
  end
end
