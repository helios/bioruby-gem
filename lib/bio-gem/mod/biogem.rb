# Biogem helpers for templates

module Biogem
  module Render
    # new hook for removing stuff
    def after_render_template(source,buf)
      if source == 'other_tasks.erb'
        $stdout.puts "\tremove jeweler rcov lines"
        # remove rcov related lines from jeweler Rakefile
        remove = "require 'rcov/rcovtask'"
        if buf =~ /#{remove}/
          # $stdout.puts buf,'---'
          buf1 = buf.split(/\n/)
          i = buf1.index(remove)
          buf = (buf1[0..i-1] + buf1[i+7..-1]).join("\n")
        end
      end
      buf
    end

    def render_template_generic(source, template_dir = template_dir_biogem)
      template_contents = File.read(path(template_dir, source))
      template          = ERB.new(template_contents, nil, '<>')

      # squish extraneous whitespace from some of the conditionals
      template.result(binding).gsub(/\n\n\n+/, "\n\n")
    end

    def output_template_in_target_generic(source, destination = source, template_dir = template_dir_biogem, write_type='w')
      final_destination = path(target_dir, destination)
      template_result   = render_template_generic(source, template_dir)

      File.open(final_destination, write_type) {|file| file.write(template_result)}
      status = 
        case write_type
          when 'w' then 'create'
          when 'a' then 'append'
        end
      $stdout.puts "\t#{status}\t#{destination}"
    end

    def output_template_in_target_generic_append(source, destination = source, template_dir = template_dir_biogem)
      final_destination = path(target_dir, destination)
      template_result   = render_template_generic(source, template_dir)

      File.open(final_destination, 'a') {|file| file.write(template_result)}

      $stdout.puts "\tappend\t#{destination}"
    end    

    def template_dir_biogem
      path(File.dirname(__FILE__),'..', 'templates')
    end

    def create_plugin_files
      if options[:biogem_meta]
        create_meta 
      else
        original_create_files
        create_lib
        create_bin if options[:biogem_bin]
        create_test_data if options[:biogem_test_data]
        create_ffi_structure if options[:biogem_ffi]
        create_db_structure if options[:biogem_db]
        create_rails_engine if options[:biogem_engine]
      end 
      # Always do these
      output_template_in_target_generic_append 'gitignore', '.gitignore', template_dir_biogem
    end

    def create_meta
      # this section is for Biogem META packages only!
      unless File.exists?(target_dir) || File.directory?(target_dir)
        FileUtils.mkdir target_dir
      else
        raise FileInTheWay, "The directory #{target_dir} already exists, aborting. Maybe move it out of the way before continuing?"
      end
      output_template_in_target '.gitignore'
      output_template_in_target 'Rakefile'
      output_template_in_target 'Gemfile'  if should_use_bundler
      output_template_in_target 'LICENSE.txt'
      output_template_in_target 'README.rdoc'
      output_template_in_target '.document'
    end

    def create_lib
      output_template_in_target_generic path('lib/bioruby-plugin.rb'), path(lib_dir, lib_filename)
    end

    def create_bin
      # create the 'binary' in ./bin
      mkdir_in_target bin_dir
      output_template_in_target_generic path('bin/bio-plugin'), path(bin_dir, bin_name)
      # TODO: set the file as executable
      File.chmod 0655, path(target_dir, bin_dir, bin_name)
    end

    def create_test_data
      mkdir_in_target("test") unless File.exists? "#{target_dir}/test"
      mkdir_in_target test_data_dir  
    end

    def create_ffi_structure
      # create ./ext/src and ./ext/include for the .c and .h files
      mkdir_in_target(ext_dir)
      src_dir = path(ext_dir,'src')
      mkdir_in_target(src_dir)
      # create ./lib/ffi for the Ruby ffi
      mkdir_in_target(path(lib_dir,"ffi"))
      # copy C files
      output_template_in_target_generic path('ffi/ext.c'), path(src_dir, "ext.c" )
      output_template_in_target_generic path('ffi/ext.h'), path(src_dir, "ext.h" )
    end

    def create_db_structure
      migrate_dir = path(db_dir, "migrate")
      mkdir_in_target(db_dir)
      mkdir_in_target(migrate_dir)
      mkdir_in_target("config") unless exists_dir?("config")
      mkdir_in_target(path("lib/bio"))
      mkdir_in_target(lib_sub_module)
      output_template_in_target_generic 'database', path("config/database.yml")
      output_template_in_target_generic 'migration', path(migrate_dir,"001_create_example.rb" )
      output_template_in_target_generic 'seeds', path(db_dir, "seeds.rb")
      output_template_in_target_generic 'rakefile', 'Rakefile', template_dir_biogem, 'a' #need to spec all the option to enable the append option
      #TODO I'd like to have a parameter from command like with defines the Namespace of the created bio-gem to automatically costruct directory structure
      output_template_in_target_generic 'db_connection', path(lib_sub_module,"connect.rb")
      output_template_in_target_generic 'db_model', path(lib_sub_module,"example.rb")
    end

    def create_rails_engine
      # create the structures and files needed to have a ready to go Rails' engine
      engine_dirs.each do |dir|
        mkdir_in_target(dir) unless exists_dir?(dir)
      end
      output_template_in_target_generic 'engine', path('lib', engine_filename )
      output_template_in_target_generic_append 'library', path('lib', lib_filename)
      output_template_in_target_generic 'routes', path('config', "routes.rb" )
      output_template_in_target_generic 'foos_controller', path('app',"controllers", "foos_controller.rb" )
      output_template_in_target_generic 'foos_view_index', path('app',"views","foos", "index.html.erb" )
      output_template_in_target_generic 'foos_view_show', path('app',"views","foos", "show.html.erb" )
      output_template_in_target_generic 'foos_view_example', path('app',"views","foos", "example.html.erb" )
      output_template_in_target_generic 'foos_view_new', path('app',"views","foos", "new.html.erb" )
    end
  end

  module Path

    def path(*items)
      File.join(*items).gsub(File::SEPARATOR, File::ALT_SEPARATOR || File::SEPARATOR)
    end

    def exists_dir?(dir)
      Dir.exists?(path(target_dir,dir))
    end

    def lib_dir
      'lib'
    end

    def lib_filename
      "#{project_name}.rb"
    end

    def require_name
      project_name
    end

    def test_data_dir
      'test/data'
    end

    def db_dir
      'db'
    end

    def bin_dir
      'bin'
    end

    def ext_dir
      'ext'
    end

    def bin_name
      "#{original_project_name}"
    end
  end

  module Naming
    def engine_dirs
      %w{app app/controllers app/views app/helpers config app/views/foos}
    end

    def engine_name
      "#{project_name}-engine"
    end

    def engine_filename
      "#{engine_name}.rb"
    end

    def engine_module_name
      project_name.split('-').map{|module_sub_name| module_sub_name.capitalize}.join      
    end

    def engine_name_prefix
      project_name.split('-').gsub(/-/,'_')<<'_'
    end

    def engine_namespace
      "/#{options[:biogem_engine]}"
    end
    
    def sub_module
      project_name.split('-')[1..-1].map{|x| x.capitalize}.join
    end
    
    def lib_sub_module
      path(lib_dir,"bio",sub_module.downcase)
    end
  end

  module Github
  end
end
