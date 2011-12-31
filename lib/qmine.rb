require "java"
require "qmine/version"
require 'qmine/mine/mine.jar'

module Qmine
  class Wrapper
    include_class 'main.BriefResult'
    include_class 'analysis.Analysis'
    include_class 'data.Dataset'
    include_class 'java.io.FileWriter'
    include_class 'java.io.BufferedWriter'
    include_class 'main.Analyze'
    
    def initialize( ext_options = {} )
      options         = default_options.merge( ext_options.delete_if{ |k,v| v.nil? })
      
      debug_stream    = FileWriter.new( options[:inputfile] + "_debug" )
      debug_out       = BufferedWriter.new( debug_stream )
      dataset         = Dataset.new( options[:inputfile], options[:debuglevel], debug_out)
      a               = Analysis.new(dataset,Analysis::AnalysisStyle.allPairs)
      
      results          = a.getSortedResults(
                            BriefResult,
                            options[:inputfile],
                            options[:required_common_vals_percent],
                            options[:max_num_boxes_exponent],
                            options[:num_clumps_factor],
                            options[:gc_wait],
                            '1',
                            options[:debuglevel],
                            debug_out
                          )
                          
      Analyze.printResults(results, options[:inputfile], '1')
    end
    
    def buh
    end
    
    def default_options
      {
        :debuglevel                       => 0,
        :inputfile                        => 'spec/fixtures/WHO.csv',
        :gc_wait                          => 2147483647,
        :num_clumps_factor                => 15.0,
        :required_common_vals_percent     => 0.0,
        :max_num_boxes_exponent           => 0.6
      }
    end
  end
end
