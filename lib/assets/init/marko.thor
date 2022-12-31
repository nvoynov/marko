require 'thor'
require 'clerq'

class MarkoExtra < Thor
  include Thor::Actions
  namespace :marko

  no_commands {
    def datestamp
      Time.new.strftime('%Y%m%d')
    end

    def timestamp
      Time.new.to_s
    end
  }

  desc "release", "Build artifact"
  def release
    tmp = 'release.md'
    `clerq build -t artefact.md.tt -o #{tmp}`
    Dir.chdir('bin') {
      `pandoc #{tmp} -o release_#{datestamp}.docx`
      File.delete(tmp)
    }
  end

  desc "draft", "Build draft"
  def draft
    tmp = 'draft.md'
    `clerq build -t artefact.md.tt -o #{tmp}`
    Dir.chdir('bin') {
      `pandoc #{tmp} -o draft_#{datestamp}.docx`
      File.delete(tmp)
    }
  end

  desc "toc [ID]", "Print table of content"
  def toc(id)
    tree = Clerq::Services::Query.(id)
    tree.orphan!
    tree.each do |n|
      puts "% #{n.title}" if n.root?
      puts '#' * n.nesting_level + " #{n.title} ##{n.id}"
    end
  end

  desc "todo", "Print @@todo macro"
  def todo
    tree = Clerq::Services::Query # Clerq.tree
    tree.to_a.drop(1)
      .select{|n| n.body =~ /@@todo/}
      .each{|n|
        header = "#{n.title} ##{n.id}"
        source = "#{n[:origin].origin}:#{n[:origin].lineno}"
        puts "#{header}: #{source}"
        puts n.body
          .scan(/@@todo[^\n]*\n/)
          .map{"  #{_1}"}
          .join(?\n)
      }
  end

  desc "mm [EXTRA]", "Create meeting minutes"
  def mm(extra)
    Dir.mkdir('mm') unless Dir.exist?('mm')
    name = "minutes-#{datestamp}#{extra.empty? ? '' : extra}"
    body = MINUTES % timestamp

    errm = "Minutes exists already. Maybe you can provide [EXTRA]?"
    name = File.join('mm', name)
    fail errm if File.exist?(name)
    File.write(name, body)
  end

  MINUTES = <<~EOF
    %% Meeting Minutes %s

    # Attendants

    1.
    2.

    # Questions

    1.
    2.

    # Decissions

    1.
    2.
  EOF.freeze

end
