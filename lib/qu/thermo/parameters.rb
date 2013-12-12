#!/usr/bin/env ruby 
# -*- coding: utf-8 -*- #
=begin
Thermodynamics Parameters for calculating Tm and Gibbs free energy

References

 Matched base-pair =>

 [1] SantaLucia JR (1998) "A unified view of polymer, dumbbell
 and oligonucleotide DNA nearest-neighbor thermodynamics", Proc Natl
 Acad Sci 95=>1460-65 http=>//dx.doi.org/10.1073/pnas.95.4.1460.

 Mismatched base-pair =>

 [1]. Allawi, H.T. and SantaLucia, J. (1997) Thermodynamics and NMR 
 of internal GT mismatches in DNA, Biochemistry, 36, 10581-10594.
 [2]. Allawi, H.T. and SantaLucia, J. (1998) Nearest-neighbor 
 thermodynamics of internal A center dot C mismatches in 
 DNA=> Sequence dependence and pH effects, Biochemistry, 37, 9435-9444.
 [3]. Allawi, H.T. and SantaLucia, J. (1998) Nearest neighbor 
 thermodynamic parameters for internal G center dot A mismatches 
 in DNA, Biochemistry, 37, 2170-2179.
 [4]. Allawi, H.T. and Santalucia, J. (1998) Thermodynamics of 
 internal C center dot T mismatches in DNA, Nucleic Acids 
 Research, 26, 2694-2701.

 NN model =>

 [1] SantaLucia, J. (1998) A unified view of polymer, dumbbell, and oligonucleotide DNA nearest-neighbor thermodynamics, Proceedings of the National Academy of Sci-ences of the United States of America, 95, 1460-1465.

 [2] von Ahsen, N., Wittwer, C.T. and Schutz, E. (2001) Oligonucleotide melting tempera-tures under PCR conditions=> Nearest-neighbor corrections for Mg2+, deoxynu-cleotide triphosphate, and dimethyl sulfoxide concentrations with comparison to alternative empirical formulas, Clinical Chemistry, 47, 1956-1961.

by Wubin Qu <quwubin@gmail.com>
Copyright @ 2010, All Rights Reserved.
=end

module Qu
  module Thermo
      DH = {
      'AATT' => -7.9, 'TTAA' => -7.9,
      'ATTA' => -7.2, 'TAAT' => -7.2,
      'CAGT' => -8.5, 'TGAC' => -8.5,
      'GTCA' => -8.4, 'ACTG' => -8.4,
      'CTGA' => -7.8, 'AGTC' => -7.8,
      'GACT' => -8.2, 'TCAG' => -8.2,
      'CGGC' => -10.6, 'GCCG' => -9.8, 
      'GGCC' => -8.0, 'CCGG' => -8.0, 
      'initCG' => 0.1, 'initGC' => 0.1, 
      'initAT' => 2.3, 'initTA' => 2.3, 
      # Like pair mismatches 
      'AATA' => 1.2, 'ATAA' => 1.2, 
      'CAGA' => -0.9, 'AGAC' => -0.9, 
      'GACA' => -2.9, 'ACAG' => -2.9, 
      'TAAA' => 4.7, 'AAAT' => 4.7, 
      'ACTC' => 0.0, 'CTCA' => 0.0, 
      'CCGC' => -1.5, 'CGCC' => -1.5, 
      'GCCC' => 3.6, 'CCCG' => 3.6, 
      'TCAC' => 6.1, 'CACT' => 6.1, 
      'AGTG' => -3.1, 'GTGA' => -3.1, 
      'CGGG' => -4.9, 'GGGC' => -4.9, 
      'GGCG' => -6.0, 'GCGG' => -6.0, 
      'TGAG' => 1.6, 'GAGT' => 1.6, 
      'ATTT' => -2.7, 'TTTA' => -2.7, 
      'CTGT' => -5.0, 'TGTC' => -5.0, 
      'GTCT' => -2.2, 'TCTG' => -2.2, 
      'TTAT' => 0.2, 'TATT' => 0.2, 
      # G.T mismatches 
      'AGTT' => 1.0, 'TTGA' => 1.0, 
      'ATTG' => -2.5, 'GTTA' => -2.5, 
      'CGGT' => -4.1, 'TGGC' => -4.1, 
      'CTGG' => -2.8, 'GGTC' => -2.8, 
      'GGCT' => 3.3, 'TCGG' => 3.3, 
      'GGTT' => 5.8, 'TTGG' => 5.8, 
      'GTCG' => -4.4, 'GCTG' => -4.4, 
      'GTTG' => 4.1, 'GTTG' => 4.1, 
      'TGAT' => -0.1, 'TAGT' => -0.1, 
      'TGGT' => -1.4, 'TGGT' => -1.4, 
      'TTAG' => -1.3, 'GATT' => -1.3, 
      #G.A mismatches
      'AATG' => -0.6, 'GTAA' => -0.6, 
      'AGTA' => -0.7, 'ATGA' => -0.7, 
      'CAGG' => -0.7, 'GGAC' => -0.7, 
      'CGGA' => -4.0, 'AGGC' => -4.0, 
      'GACG' => -0.6, 'GCAG' => -0.6, 
      'GGCA' => 0.5, 'ACGG' => 0.5, 
      'TAAG' => 0.7, 'GAAT' => 0.7, 
      'TGAA' => 3.0, 'AAGT' => 3.0, 
      #C.T mismatches
      'ACTT' => 0.7, 'TTCA' => 0.7, 
      'ATTC' => -1.2, 'CTTA' => -1.2, 
      'CCGT' => -0.8, 'TGCC' => -0.8, 
      'CTGC' => -1.5, 'CGTC' => -1.5, 
      'GCCT' => 2.3, 'TCCG' => 2.3, 
      'GTCC' => 5.2, 'CCTG' => 5.2, 
      'TCAT' => 1.2, 'TACT' => 1.2, 
      'TTAC' => 1.0, 'CATT' => 1.0, 
      #A.C mismatches
      'AATC' => 2.3, 'CTAA'=>2.3, 
      'ACTA' => 5.3, 'ATCA'=>5.3, 
      'CAGC' => 1.9, 'CGAC'=>1.9, 
      'CCGA' => 0.6, 'AGCC'=>0.6, 
      'GACC' => 5.2, 'CCAG'=>5.2, 
      'GCCA' => -0.7, 'ACCG'=>-0.7, 
      'TAAC' => 3.4, 'CAAT'=>3.4, 
      'TCAA' => 7.6, 'AACT'=>7.6,

      #tandem mismatch
      'GGTT' => 5.8,  'TTGG' => 5.8,   
      'GTTG' => 4.1,  'TGGT' => -1.4, 
      'GTTT' => 5.8,  'TTTG' => 5.8,
      'GTAT' => -0.1, 'TATG' => -0.1,
      #single bulge loop 
      'AAAT-T' => -4.0,  'AATT-A' => -13.5, 'AACT-G' => 10.2,  'AAGT-C' => -0.2,
      'ATAT-T' => 9.8,   'ATTT-A' => -19.5, 'ATCT-G' => -4.8,  'ATGT-C' => 5.6,
      'ACAT-T' => 6.1,   'ACTT-A' => -3.4,  'ACCT-G' => -29.1, 'ACGT-C' => -1.2,
      'AGAT-T' => 15.5,  'AGTT-A' => 5.3,   'AGCT-G' => -7.2,  'AGGT-C' => 5.7,
      'TAAA-T' => 15.3,  'TATA-A' => 19.8,  'TACA-G' => -2.3,  'TAGA-C' => 15,
      'TTAA-T' => -2.7,  'TTTA-A' => -8.2,  'TTCA-G' => 8.8,   'TTGA-C' => 7.0,
      'TCAA-T' => 1.6,   'TCTA-A' => 9.9,   'TCCA-G' => -15.2, 'TCGA-C' => -0.7,
      'TGAA-T' => -12.3, 'TGTA-A' => 20.9,  'TGCA-G' => 2.6,   'TGGA-C' => -9.2,
      'CAAG-T' => -14.4, 'CATG-A' => -7.0,  'CACG-G' => 4.3,   'CAGG-C' => -2.9,
      'CTAG-T' => -18.7, 'CTTG-A' => -4.6,  'CTCG-G' => -14.5, 'CTGG-C' => -4.7,
      'CCAG-T' => 5.8,   'CCTG-A' => -5.3,  'CCCG-G' => -2.6,  'CCGG-C' => 9.1,
      'CGAG-T' => -14.7, 'CGTG-A' => 2.1,   'CGCG-G' => -4.4,  'CGGG-C' => -16.4,
      'GAAC-T' => -6.8,  'GATC-A' => -9.8,  'GACC-G' => -4.8,  'GAGC-C' => -6.5,
      'GTAC-T' => -7.4,  'GTTC-A' => 1.8,   'GTCC-G' => -12.3, 'GTGC-C' => -2.3,
      'GCAC-T' => -2.1,  'GCTC-A' => -3.5,  'GCCC-G' => 0.4,   'GCGC-C' => 13.8,
      'GGAC-T' => 2.7,   'GGTC-A' => -1.2,  'GGCC-G' => -1.7,  'GGGC-C' => 3.5,
      # single dangling_end
      'AA-T' => 0.2,  'TA-T' => -6.9,  'GA-T' => -1.1, 'CA-T' => 0.6,
      'AC-G' => -6.3, 'TC-G' => -4.0,  'GC-G' => -5.1, 'CC-G' => -4.4,
      'AG-C' => -3.7, 'TG-C' => -4.9,  'GG-C' => -3.9, 'CG-C' => -4.0,
      'AT-A' => -2.9, 'TT-A' => -0.2,  'GT-A' => -4.2, 'CT-A' => -4.1,
      'AAT-' => -0.5, 'ACT-' => 4.7,   'AGT-' => -4.1, 'ATT-' => -3.8,
      'TAA-' => -0.7, 'TCA-' => 4.4,   'TGA-' => -1.6, 'TTA-' => 2.9,
      'GAC-' => -2.1,  'GCC-' => -0.2,  'GGC-' => -3.9, 'GTC-' => -4.4,
      'CAG-' => -5.9, 'CCG-' => -2.6,  'CGG-' => -3.2, 'CTG-' => -5.2,  
      # long dangling_end
      'CAAG--' => -2.15, 'CAAAG---' => -3.3,  'CAAAAG----' => -4.85,
      'TAAA--' => -1.0,  'TAAAA---' => -1.95, 'TAAAAA----' => -2.35,
      'AAA--T' => -1.5,  'AAAA---T' => -1.75, 'AAAAA----T' => -3.95,
      'AAG--C' => -0.25, 'AAAG---C' => -0.15, 'AAAAG----C' => -0.75,    
      }

      #--------------------#
      # deltaS (cal/K.mol) #
      #--------------------#
      DS = {
      'AATT' => -22.2, 'TTAA'=>-22.2, 
      'ATTA' => -20.4, 'TAAT'=>-21.3, 
      'CAGT' => -22.7, 'TGAC'=>-22.7, 
      'GTCA' => -22.4, 'ACTG'=>-22.4, 
      'CTGA' => -21.0, 'AGTC'=>-21.0, 
      'GACT' => -22.2, 'TCAG'=>-22.2, 
      'CGGC' => -27.2, 'GCCG'=>-24.4, 
      'GGCC' => -19.9, 'CCGG'=>-19.9, 
      'initCG' => -2.8, 'initGC'=>-2.8, 
      'initAT' => 4.1, 'initTA'=>4.1, 
      'sym' => -1.4, 
      # => Like=>pair=>mismatches
      'AATA' => 1.7, 'ATAA'=>1.7, 
      'CAGA' => -4.2, 'AGAC'=>-4.2, 
      'GACA' => -9.8, 'ACAG'=>-9.8, 
      'TAAA' => 12.9, 'AAAT'=>12.9, 
      'ACTC' => -4.4, 'CTCA'=>-4.4, 
      'CCGC' => -7.2, 'CGCC'=>-7.2, 
      'GCCC' => 8.9, 'CCCG'=>8.9, 
      'TCAC' => 16.4, 'CACT'=>16.4, 
      'AGTG' => -9.5, 'GTGA'=>-9.5, 
      'CGGG' => -15.3, 'GGGC'=>-15.3, 
      'GGCG' => -15.8, 'GCGG'=>-15.8, 
      'TGAG' => 3.6, 'GAGT'=>3.6, 
      'ATTT' => -10.8, 'TTTA'=>-10.8, 
      'CTGT' => -15.8, 'TGTC'=>-15.8, 
      'GTCT' => -8.4, 'TCTG'=>-8.4, 
      'TTAT' => -1.5, 'TATT'=>-1.5, 
      # => G.T=>mismatches
      'AGTT' => 0.9, 'TTGA'=>0.9, 
      'ATTG' => -8.3, 'GTTA'=>-8.3, 
      'CGGT' => -11.7, 'TGGC'=>-11.7, 
      'CTGG' => -8.0, 'GGTC'=>-8.0, 
      'GGCT' => 10.4, 'TCGG'=>10.4, 
      'GGTT' => 16.3, 'TTGG'=>16.3, 
      'GTCG' => -12.3, 'GCTG'=>-12.3, 
      'GTTG' => 9.5, 'GTTG'=>9.5, 
      'TGAT' => -1.7, 'TAGT'=>-1.7, 
      'TGGT' => -6.2, 'TGGT'=>-6.2, 
      'TTAG' => -5.3, 'GATT'=>-5.3, 
      #  G.A mismatches
      'AATG' => -2.3, 'GTAA' => -2.3, 
      'AGTA' => -2.3, 'ATGA' => -2.3, 
      'CAGG' => -2.3, 'GGAC' => -2.3, 
      'CGGA' => -13.2, 'AGGC' => -13.2, 
      'GACG' => -1.0, 'GCAG' => -1.0, 
      'GGCA' => 3.2, 'ACGG' => 3.2, 
      'TAAG' => 0.7, 'GAAT' => 0.7, 
      'TGAA' => 7.4, 'AAGT' => 7.4, 
      # C.T mismatches
      'ACTT' => 0.2, 'TTCA' => 0.2, 
      'ATTC' => -6.2, 'CTTA' => -6.2, 
      'CCGT' => -4.5, 'TGCC' => -4.5, 
      'CTGC' => -6.1, 'CGTC' => -6.1, 
      'GCCT' => 5.4, 'TCCG' => 5.4, 
      'GTCC' => 13.5, 'CCTG' => 13.5, 
      'TCAT' => 0.7, 'TACT' => 0.7, 
      'TTAC' => 0.7, 'CATT' => 0.7, 
      # A.C mismatches
      'AATC' => 4.6, 'CTAA' => 4.6, 
      'ACTA' => 14.6, 'ATCA' => 14.6, 
      'CAGC' => 3.7, 'CGAC' => 3.7, 
      'CCGA' => -0.6, 'AGCC' => -0.6, 
      'GACC' => 14.2, 'CCAG' => 14.2, 
      'GCCA' => -3.8, 'ACCG' => -3.8, 
      'TAAC' => 8.0, 'CAAT' => 8.0, 
      'TCAA' => 20.2, 'AACT' => 20.2,
      # tandem mismatch
      'GGTT' => 16.3, 'TTGG' => 16.3,   
      'GTTG' => 9.5,  'TGGT' => -6.2, 
      'GTTT' => 16.3, 'TTTG' => 16.3,
      'GTAT' => -1.7, 'TATG' => -1.7, 
      # single bulge loop
      'AAAT-T' => -17.5, 'AATT-A' => -44.6, 'AACT-G' => 25.8,  'AAGT-C' => -4.6,
      'ATAT-T' => 24.7,  'ATTT-A' => -61.8, 'ATCT-G' => -20.0, 'ATGT-C' => 12.9,
      'ACAT-T' => 14.0,  'ACTT-A' => -15.3, 'ACCT-G' => -91.3, 'ACGT-C' => -7.4,
      'AGAT-T' => 43.1,  'AGTT-A' => 10.6,  'AGCT-G' => -28.4, 'AGGT-C' => 14.4,
      'TAAA-T' => 38.5,  'TATA-A' => 56.7,  'TACA-G' => -12.7, 'TAGA-C' => 40.4,
      'TTAA-T' => -16.0, 'TTTA-A' => -30.1, 'TTCA-G' => 23.2,  'TTGA-C' => 17.5,
      'TCAA-T' => -3.9,  'TCTA-A' => 30.5,  'TCCA-G' => -48.7, 'TCGA-C' => -7.0,
      'TGAA-T' => -47.0, 'TGTA-A' => 59.8,  'TGCA-G' => 1.6,   'TGGA-C' => -31.4,
      'CAAG-T' => -46.6, 'CATG-A' => -25.8, 'CACG-G' => 8.8,   'CAGG-C' => -13.0,
      'CTAG-T' => -61.7, 'CTTG-A' => -17.0, 'CTCG-G' => -48.1, 'CTGG-C' => -18.8,
      'CCAG-T' => 13.4,  'CCTG-A' => -24.8, 'CCCG-G' => -9.4,  'CCGG-C' => 24.4,
      'CGAG-T' => -49.6, 'CGTG-A' => 6.5,   'CGCG-G' => -17.8, 'CGGG-C' => -51.6,
      'GAAC-T' => -25.2, 'GATC-A' => -35.6, 'GACC-G' => -18.3, 'GAGC-C' => -21.0,
      'GTAC-T' => -27.0, 'GTTC-A' => -0.6,  'GTCC-G' => -40.0, 'GTGC-C' => -10.0,
      'GCAC-T' => -12.5, 'GCTC-A' => -16.1, 'GCCC-G' => -1.0,  'GCGC-C' => 42.9,
      'GGAC-T' => 3.6,   'GGTC-A' => -9.3,  'GGCC-G' => -7.2,  'GGGC-C' => 8.5,
      # single dangling_end
      'AA-T' => 2.3,   'TA-T' => -20.0, 'GA-T' => -1.6,  'CA-T' => 3.3,
      'AC-G' => -17.1, 'TC-G' => -10.9, 'GC-G' => -14.0, 'CC-G' => -12.6,
      'AG-C' => -10,   'TG-C' => -13.8, 'GG-C' => -10.9, 'CG-C' => -11.9,
      'AT-A' => -7.6,  'TT-A' => -0.5,  'GT-A' => -15.0, 'CT-A' => -13.0,
      'AAT-' => -1.1,  'ACT-' => 14.2,  'AGT-' => -13.1, 'ATT-' => -12.6,
      'TAA-' => -0.8,  'TCA-' => 14.9,  'TGA-' => -3.6,  'TTA-' => 10.4,
      'GAC-' => -3.9,  'GCC-' => -0.1,  'GGC-' => -11.2, 'GTC-' => -13.1,
      'CAG-' => -16.5, 'CCG-' => -7.4,  'CGG-' => -10.4, 'CTG-' => -15.0, 
      # long dangling_end
      'CAAG--' => -5.5, 'CAAAG---' => -8.5, 'CAAAAG----' => -13.5,
      'TAAA--' => -1.0, 'TAAAA---' => -4.5, 'TAAAAA----' => -6.0,
      'AAA--T' => -2.5, 'AAAA---T' => -3.5, 'AAAAA----T' => -10.5,
      'AAG--C' => 0.5,  'AAAG---C' => 1.5,  'AAAAG----C' => -0.5, 
      }

      LONG_BULGE_LOOP_DS = {
         '2' => -9.35,    '3' => -10.0,   '4' => -10.32,   '5' => -10.64,  '6' => -11.28,
         '7' => -11.93,   '8' => -12.57,  '9' => -13.22,  '10' => -13.86, '11' => -14.15,
         '12' => -14.51,  '13' => -15.00, '14' => -15.48,  '15' => -15.65,  '16' => -16.12,
         '17' => -16.26,  '18' => -16.77, '19' => -16.80,  '20' => -17.09,
      }

      TANDEM_MISMATCH = {
        'GT' => ['TT', 'AT', 'TG'],
        'TT' => ['TG', 'GG'],
        'TG' => ['GT'],
        'GG' => ['TT'],
        'TA' => ['TG'],
      }

      PERFECT_MATCH = {
          'A' => 'T',
          'T' => 'A',
          'C' => 'G',
          'G' => 'C',
      }

      D2I = {
          'A' => 0, 
          'T' => 3, 
          'C' => 2, 
          'G' => 1,
          '-' => 4,
          0 => 'A',
          1 => 'G',
          2 => 'C',
          3 => 'T',
          4 => '-', 
      }

      ANTISENSE_CHARS = %w{A G C T -}
  end
# end

if $0 == __FILE__
  qseq = 'GGACTGACG'
  sseq = 'CCTGGCTGC'
  p Qu::Thermo::DH
end
