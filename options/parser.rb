require "optparse"
require "ostruct"

class Parser
  # parse command-line options, returns options and a boolean
  # true if options are valid, false otherwise
  def self.parse(args)
    options = OpenStruct.new

    status = 0

    opts = OptionParser.new do |opt|
      opt.banner = "#{$0} [OPTIONS]"

      opt.on("-pPORT", "--port=PORT", "Port on which listen to connections.") do |port|
        options.port = port.to_i
        status += 1
      end

      opt.on("-dDOMAIN", "--domain=DOMAIN", "Root domain of the application") do |domain|
        options.domain = domain
        status += 1
      end

      opt.on("-bDATABASE", "--database=DATABASE", "Database filepath") do |database|
        options.database = database
        status += 1
      end
    end

    opts.parse!(args)
    options.opts = opts

    [options, status == 3]
  end
end
