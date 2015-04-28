require 'bigdecimal'
require 'benchmark'

require File.expand_path('lib/jrjackson')
require File.expand_path('benchmarking/fixtures/bench_options')

filename = File.expand_path(BenchOptions.source)

opts = {raw: true}
dumped_string = File.read(filename)

Benchmark.bmbm(BenchOptions.output_width) do |x| 
  x.report("jackson parse j raw: #{BenchOptions.iterations}") do
    BenchOptions.iterations.times { JrJackson::Raw.parse_r(dumped_string, opts) }
  end
end

Benchmark.bmbm(BenchOptions.output_width) do |x| 
  x.report("jackson parse raw: #{BenchOptions.iterations}") do
    BenchOptions.iterations.times { JrJackson::Json.load(dumped_string, opts) }
  end
end
