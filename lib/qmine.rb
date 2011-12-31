require "java"
require "qmine/version"
require 'qmine/mine/mine.jar'

module Qmine
  class Wrapper
    attr_accessor :dataset, :options

    include_class 'main.BriefResult'
    include_class 'analysis.Analysis'
    include_class 'data.Dataset'
    include_class 'java.io.FileWriter'
    include_class 'java.io.BufferedWriter'
    include_class 'main.Analyze'
    
    def self.get_dataset( ext_options = {} )
      options   = default_get_dataset_options.merge( ext_options.delete_if{ |k,v| v.nil? })
      dataset   = nil


      if( options[:inputfile] )
        debug_stream    = FileWriter.new( options[:inputfile] + "_debug" )
        debug_out       = BufferedWriter.new( debug_stream )
        dataset         = Dataset.new( options[:inputfile], options[:debuglevel], debug_out)
      end


      return dataset
    end

    def self.default_get_dataset_options
      {
        :inputfile                        => 'spec/fixtures/WHO.csv',
        :debuglevel                       => 0
      }
    end

    def self.print( results, output )
      Analyze.printResults(results, output, '1')
    end

    def initialize( ext_options = {} )
      options         = default_options.merge( ext_options.delete_if{ |k,v| v.nil? })

      @dataset        = options.delete(:dataset)
      @options        = options
    end
    
    def analyze( style = 'allPairs' )
      analysis          = Analysis.new(@dataset, Analysis::AnalysisStyle.allPairs)
      results           = analysis.getSortedResults(
                            BriefResult,
                            @options[:id],
                            @options[:required_common_vals_percent],
                            @options[:max_num_boxes_exponent],
                            @options[:num_clumps_factor],
                            @options[:gc_wait],
                            '1',
                            @options[:debuglevel],
                            @debug_out
                          )

      return results
    end



    
    def default_options
      {
        :dataset                          => nil,
        :id                               => "uuid",
        :debuglevel                       => 0,
        :gc_wait                          => 2147483647,
        :num_clumps_factor                => 15.0,
        :required_common_vals_percent     => 0.0,
        :max_num_boxes_exponent           => 0.6
      }
    end
  end
end
