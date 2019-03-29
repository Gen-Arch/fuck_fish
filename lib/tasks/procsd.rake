require 'yaml'

ROOT = File.expand_path('../../', __dir__)

namespace :procsd do
  desc 'create procsd.yml'
  task :create_yml do
    procsd = { 'app' => "", 'environment' => {} }
    print "create directory?(default: #{ROOT}) : "
    dir = $stdin.gets.chomp
    dir = ROOT if dir.empty?

    print 'app name? : '
    name = $stdin.gets.chomp
    name = 'app' if name.empty?
    procsd['app'] = name

    print 'first env?(default: development) : '
    env = $stdin.gets.chomp
    env = 'development' if env.empty?
    procsd['environment'].merge!('APP_ENV' => env)

    print 'relative_url_root?(default: /) : '
    url = $stdin.gets.chomp
    url = '/' if url.empty?
    procsd['environment'].merge!('RELATIVE_URL_ROOT' => url)

    print "database name?(default: #{name}) : "
    db = $stdin.gets.chomp
    db = name  if db.empty?
    procsd['environment'].merge!('DATABASE_NAME' => db)

    print 'mongo username? : '
    mongo_name = $stdin.gets.chomp
    abort 'name is empty' if mongo_name.empty?
    procsd['environment'].merge!('MONGODB_USER' => mongo_name)

    print 'mongo password? : '
    mongo_pass = $stdin.gets.chomp
    abort 'password is empty' if mongo_pass.empty?
    procsd['environment'].merge!('MONGODB_PASS' => mongo_pass)

    print 'mongo-express username? : '
    mongo_express_name = $stdin.gets.chomp
    abort 'name is empty' if mongo_express_name.empty?
    procsd['environment'].merge!('ME_CONFIG_BASICAUTH_USERNAME' => mongo_express_name)

    print 'mongo-express password? : '
    mongo_express_pass = $stdin.gets.chomp
    abort 'password is empty' if mongo_express_pass.empty?
    procsd['environment'].merge!('ME_CONFIG_BASICAUTH_PASSWORD' => mongo_express_pass)

    YAML.dump(procsd, open(File.join(dir, 'procsd.yml'), 'w'))
  end
end
