class BloggerException
  def initialize
    @filename = $0
    @line_number = $!.backtrace[0].split(':')[1]
    @cause = $!.backtrace[0].split('`')[-1]
    @message = $!.message
    @type = $!.class.to_s
    @description = generate_description(self.type.to_sym)
    @scope = $!.backtrace[0].split(/\./)[0]
    @time = Time.now
  end

  DESCRIPTIONS = {
    ZeroDivisionError: "Attempting to divide an Integer by 0.", 
    NoMethodError: "A method is called on a receiver that does not have that method defined."
  }

  def to_s
    <<~MLS 
    :filename: #{filename}
    :line_number: #{line_number}
    :cause: #{cause}
    :message: #{message}
    :type: #{type}
    :description #{description}
    :scope: #{scope}
    :time: #{time}
    MLS
  end

  def log
    File.open('structured_exceptions.yml', 'a+') do |file|
      file.write (self.to_yaml)
    end 
    puts 'Bug Logged Successfully:'
  end

  def generate_description(type)
    return DESCRIPTIONS[type] if DESCRIPTIONS.key?(type)
    return 'Check out https://ruby-doc.org/core-2.7.0/Exception.html for more information.'
  end

  attr_reader :filename, :line_number, :type, 
              :description, :time
private
  attr_reader :cause,
              :message, 
              :scope
end