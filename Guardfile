# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  # with Minitest::Unit
  #watch(%r|^test/test_(.*)\.rb|)
  #watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  #watch(%r|^test/test_helper\.rb|)    { "test" }

  # with Minitest::Spec
  watch(%r|^rake_routes_normalizer\.gemspec|) { "spec" }
  watch(%r|^lib/rake_routes_normalizer\.rb|)  { "spec" }
  watch(%r|^lib/(.*)\.rb|)                    { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r|^spec/spec_helper\.rb|)            { "spec" }
  watch(%r|^spec/(.*)_spec\.rb|)
end
