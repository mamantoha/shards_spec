require "../src/shards_spec"

str = <<-YAML
name: crest
version: 0.26.6

authors:
  - Anton Maminov <anton.maminov@gmail.com>

description: |
  HTTP and REST client for Crystal

crystal: ">= 0.36.0"

dependencies:
  http-client-digest_auth:
    github: mamantoha/http-client-digest_auth
    version: ~> 0.6.0
  http_proxy:
    github: mamantoha/http_proxy
    version: ~> 0.8.0

development_dependencies:
  kemal:
    github: kemalcr/kemal
    version: ~> 0.27.0
  ameba:
    github: crystal-ameba/ameba

license: MIT
YAML

spec = ShardsSpec::Spec.from_yaml(str)

spec.name
# crest

puts spec.description
# HTTP and REST client for Crystal

puts spec.crystal
# >= 0.36.0

spec.version
# 0.26.6

spec.dependencies.each do |dependency|
  "#{dependency.name} | #{dependency.version}"
end
# http-client-digest_auth | ~> 0.6.0
# http_proxy | ~> 0.8.0

spec.development_dependencies.each do |dependency|
  "#{dependency.name} | #{dependency.version}"
end
# kemal | ~> 0.27.0
# ameba | *

spec.authors.each do |author|
  "#{author.name} | #{author.email}"
end
# => Anton Maminov | anton.maminov@gmail.com

spec.license
# => MIT
