require "qu/thermo/version"
require_relative "thermo/parameters"


module Qu
  module Thermo
    class Hybrid
      def initialize(qseq, sseq, mono=50, diva=1.5, dntp=0.25, oligo=50)
        # qseq: 5' -> 3'
        # sseq: 3' -> 5'
        @qseq = qseq.upcase
        @sseq = sseq.upcase
        @mono = mono.to_f
        @diva = diva.to_f
        @dntp = dntp.to_f
        @oligo = oligo.to_f

        @dh, @ds = delta_hs
        @adjusted_mono = (@mono + diva2mono) / 1000.0
        @adjusted_ds = @ds + 0.368 * (@sseq.size - 1) * Math.log(@adjusted_mono, Math::E)
      end

      def dg
        (@dh * 1000 - (273.15 + 37) * @adjusted_ds) / 1000.0
      end

      def tm
        @dh * 1000.0 / (@adjusted_ds + 1.987 * Math.log(@oligo / 1000000000.0 / 4, Math::E)) - 273.15
      end

      def dg_tm
        return dg, tm
      end

      private

      def diva2mono
        @dntp = 0 if @diva == 0

        $stderr.puts "Error conc for diva and mono" if @diva < 0 or @dntp < 0

        @diva = @dntp if @diva < @dntp

        return 120 * (Math.sqrt(@diva - @dntp))
      end

      def delta_hs
        init_start = "init#{@qseq[0]}#{@sseq[0]}"
        init_stop = "init#{@qseq[-1]}#{@sseq[-1]}"

        dh = ds = 0
        if DH.include?(init_start) and DH.include?(init_stop)
          dh = DH[init_start] + DH[init_stop]
          ds = DS[init_start] + DS[init_stop]
        end

        (0...(@qseq.size - 1)).each do |i|
          dinuc = "#{@qseq[i...(i+2)]}#{@sseq[i...(i+2)]}"
          if DH.include?(dinuc) and DS.include?(dinuc)
            dh += DH[dinuc]
            ds += DS[dinuc]
          end
        end

        return dh, ds
      end
    end
  end
end
