#!/usr/bin/ruby -w
#
# Fretboard -- class to be used to learn the guitar fretboard
#
# == Synopsis
#   This program provides configurable drilling sessions for learning
#   the notes on the guitar fretboard.  Currently, the range of frets
#   is constrained to only the first twelve.  Also, only the standard
#   EADGBE tuning is supported by default but is easily changed in the
#   code.
#
# == Examples
#   The following command invocation drills the user on only the first
#   two strings (E and B):
#     fretboard -s 1:2
#
#   The following command invocation constrains drilling to strings
#   3 and 4 for only frets 7 through 12:
#     fretboard -s 3:4 -f 7:12
#
# == Usage
#   See Options below.
#
#   For help use: fretboard --help
#
# == Options
#   -h, --help                    Display help message
#   -t, --timeout SECONDS         Set timeout on user response
#   -f MIN[:MAX]                  Set fret number(s) to drill
#                                 (default 0-12)
#   -s MIN[:MAX]                  Set string number(s) to drill
#                                 (default 1-6)
#   -d, --display [flat|sharp]    Show fretboard
#   -l, --log LOGFILE             Log session score to LOGFILE
#   -v, --version                 Show version
#
# == Author
#   Mark DeWandel
#
# == Copyright
#   Copyright (c) 2009 Mark DeWandel.  Licensed under the GPL:
#   http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt

require 'optparse'
require 'timeout'
require 'pp'

begin
  require 'rubygems'
  require 'term/ansicolor'
  include Term::ANSIColor
rescue LoadError
  def green(args)
    args
  end

  def red(args)
    args
  end

  def bold(args)
    args
  end
end

# Fretboard class for learning the guitar fretboard.
class Fretboard
  FRETS = 12
  STRINGS = 6
  VERSION = '0.0.9'

  def self.display_version
    puts "#{File.basename(__FILE__)} version #{VERSION}"
  end

  def self.parse_args(args)
    options = Hash.new

    op = OptionParser.new do |opts|
      opts.on("-t SECONDS", "--timeout SECONDS",
        "Set timeout on prompt") do |opt|
        options[:timeout] = opt.to_i
      end
    
      opts.on("-f MIN[:MAX]", "--fret MIN[:MAX]",
        "Set fret number(s) to drill (default 0-12)") do |opt|
        o = opt.split(":")
        o.each { |s| s.strip! }
        options[:fret] = o
      end
    
      opts.on("-s MIN[:MAX]", "--string MIN[:MAX]",
        "Set string number(s) on which to drill",
        "(default 1-6)") do |opt|
        o = opt.split(":")
        o.each { |s| s.strip! }
        options[:string] = o
      end

      opts.on("-d [0|1]", "--display [FLAT|SHARP]", "Show fretboard") do |opt|
        options[:show_fretboard] = opt
      end

      opts.on("-l LOGFILE", "--log LOGFILE", "Log score to LOGFILE") do |opt|
        options[:logfile] = opt
      end

      opts.on("-v", "--version", "Show version") do
        display_version
        exit 0
      end
    end

    begin
      op.parse!(args)
    rescue OptionParser::ParseError => e
        puts e
        exit 1
    end
    options
  end

  def initialize(args)
    @timeout = args[:timeout] || 0

    if args.has_key?(:fret)
      a = args[:fret]
      @first_fret = a[0].to_i
      @last_fret = a.size == 2 ? a[1].to_i : @first_fret
    else
      @first_fret = 0
      @last_fret = FRETS
    end

    if @first_fret < 0 || @first_fret > FRETS ||
      @last_fret < 0 || @last_fret > FRETS ||
      @first_fret > @last_fret
      raise ArgumentError, "Invalid FRET value/range specified"
    end

    if args.has_key?(:string)
      a = args[:string]
      @first_string = a[0].to_i
      @last_string = a.size == 2 ? a[1].to_i : @first_string
    else
      @first_string = 1
      @last_string = STRINGS
    end

    if @first_string < 1 || @first_string > STRINGS ||
      @last_string < 1 || @last_string > STRINGS ||
      @first_string > @last_string
      raise ArgumentError, "Invalid STRING value/range specified"
    end

    @logfile = nil
    if args.has_key?(:logfile)
      @logfile = File.open(args[:logfile], "a")
    end

    @frets=(0..FRETS)
    @strings=(0..STRINGS-1)

    scale_sharps = %w(A A# B C C# D D# E F F# G G#)
    scale_flats  = %w(A Bb B C Db D Eb E F Gb G Ab)
    accidentals  = [1, 4, 6, 9, 11]

    # This is for the standard EADGBE tuning
    scale_index = [7, 2, 10, 5, 0, 7]

    @fretboard = []

    #
    # Fretboard is an array of strings indexed by fret number
    #
    row = []
    @frets.each do |i|
      @strings.each do |j|
        s = (scale_index[j] + i) % 12

        # For positions which contain accidentals, represent both
        # sharps and flats for the given string and fret with a
        # subarray.
        if accidentals.include?(s)
          row[j] = [scale_sharps[s], scale_flats[s]]
        else
          row[j] = scale_sharps[s]
        end
        s = (s == scale_sharps.size - 1) ? 0 : s + 1
      end
      @fretboard << row
      row = []
    end

    if args.has_key?(:show_fretboard)
      self.display(args[:show_fretboard] == "sharp" ? true : false)
    end

    # Select random fret and string numbers from within the specified
    # ranges
    @fret_max = @last_fret - @first_fret + 1
    @string_max = @last_string - @first_string + 1

  rescue => e
    puts "Error: " + e
    exit 1
  end

  # Display an ASCII chart of the guitar fretboard
  def display(sharps = true)
    nut =  "    ===============================\n"
    pos =  " %2d | %-2s | %-2s | %-2s | %-2s | %-2s | %-2s |\n"
    fret = "    +-----------------------------+\n"

    @fretboard.each_with_index do |row, i|
      r = *row.reverse
      r.each_with_index do |e, j|
        if r[j].is_a?(Array)
          slot = sharps ? 0 : 1
          r[j, 1] = r[j][slot]
        end
      end
      if i == 0
        printf(pos, i, *r)
        puts nut
        next
      end
      printf(pos, i, *r)
      puts fret
    end
  end

  # Return string representation of Fretboard instance.
  def to_s
    str = ""
    @frets.each_with_index do |f, i|
      str << "#{i}: " + @fretboard[f].reverse.inspect + "\n"
    end
    str
  end
  alias :inspect :to_s

  # Private version of +gets+ which respects optional timeout.
  def gets
    s = ""
    timed_out = false
    begin
      Timeout::timeout(@timeout) do
        s = $stdin.gets
        exit if s == nil
        s.chomp!
      end
    rescue Timeout::Error
      timed_out = true
    end
    [s, timed_out]
  end

  # Run the main query loop for the fretboard trainer.
  def run
    i = 1
    errors = 0

    at_exit do
      puts "\n\nYou missed #{errors} out of #{i}.\n\n"
      if @logfile
        t = Time.now
        @logfile.puts "[#{t}] String #{@first_string}:#{@last_string}, "  +
          "Fret #{@first_fret}:#{@last_fret} -- Missed #{errors} out of #{i}"
      end
    end

    # Skip stack traceback on ctrl-c
    trap("SIGINT") { exit }

    loop do
      s = @first_string + rand(@string_max)
      f = @first_fret + rand(@fret_max)
      printf("\n[#{i}] String #{s}, fret #{f}\n")
      printf("? ")
      $stdout.flush
      ans, timed_out = gets
      ans = ans.chomp.downcase
      note = @fretboard[f][s-1]
      correct = false

      if note.is_a?(Array)
        puts "  #{note[0]} / #{note[1]}"
        if ans == note[0].downcase || ans.downcase == note[1].downcase
          correct = true
        end
      else
        puts "  #{@fretboard[f][s-1]}"
        if ans.upcase == @fretboard[f][s-1].to_s
          correct = true
        end
      end

      if correct
        puts green(bold("Correct."))
      else
        errors += 1
        puts red(bold("Incorrect.")) + (timed_out ? " [Timeout]" : "")
        if timed_out
          printf("\nContinue? ")
          $stdin.gets
        end
      end

      i += 1
    end
  end

  private :gets
end

if $0 == __FILE__
  opts = Fretboard::parse_args(ARGV)
  Fretboard.new(opts).run
end
