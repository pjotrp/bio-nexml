module Bio
  # = DESCRIPTION
  # Bio::NeXML module holds the <em>nexml</em> parsing and serailizing library of BioRuby.
  # Any reference to <em>nexml</em> as a document format, or to its elements or to <em>nexml</em>
  # schema has been emphasised.
  module NeXML

    #exception classes
    class InvalidRowException < Exception; end
    class InvalidMatrixException < Exception; end
    class InvalidCharException < Exception; end
    class InvalidStateException < Exception; end
    class InvalidStatesException < Exception; end
    class InvalidFormatException < Exception; end
    class InvalidTokenException < Exception; end
    class InvalidSequenceException < Exception; end
    class InvalidSeqException < Exception; end
    class InvalidCellException < Exception; end
    class InvalidCodonPositionException < Exception; end
    class InvalidMemberException < Exception; end

    # = DESCRIPTION
    # Abstract <em>characters</em> implementation of <em>AbstractBlock</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractBlock] type.
    # This class defines <tt>format</tt> attribute accessor but not writer. A concrete subclass must define a <tt>format=</tt> attribute writer.
    # Following are the subclasses of Bio::NeXML::Characters:
    # * Bio::NeXML::Seqs
    # * Bio::NeXML::Cells
    class Characters

      include TaxaLinked
      attr_reader :format

      def initialize( id, otus, label = nil )
        @id = id
        @otus = otus
        @label = label
      end

      # Abstract method. Adds a <em>format</em> element to <tt>self</tt>.
      # It calls the <tt>format=</tt> method of its concrete subtype to do so.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::Format object
      def <<( format )
        self.format = format
      end

    end #end class Characters

    # = DESCRIPTION
    # Abstract <em>characters</em> implementation of <em>AbstractSeqs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractSeqs] type.
    # This class defines <tt>matrix</tt> attribute accessor but not writer. A concrete subclass must define a <tt>matrix=</tt> attribute writer. Since this class 
    # inherits from Bio::NeXML::Characters a <tt>format=</tt> method must also be defined by a concrete subclass.
    # Following classes extend Bio::NeXML::Seqs:
    # * Bio::NeXML::ProteinSeqs
    # * Bio::NeXML::DnaSeqs
    # * Bio::NeXML::RnaSeqs
    # * Bio::NeXML::RestrictionSeqs
    # * Bio::NeXML::ContinuousSeqs
    # * Bio::NeXML::StandardSeqs
    class Seqs < Characters

      attr_reader :matrix

      def initialize( id, otus, label = nil )
        super
      end

      # Abstract method. Adds a <em>format</em> or a <em>matrix</em> element to <tt>self</tt>.
      # It calls the <tt>format=</tt> or <tt>matrix=</tt> method of its concrete subtype
      # to do so.
      # ---
      # *Arguments*
      # * element( required ) - a Bio::NeXML::Format or a Bio::NeXML::SeqMatrix object.
      def <<( element )
        case element
        when Matrix
          raise InvalidMatrixException, "SeqMatrix expected." unless element.kind_of? SeqMatrix
          self.matrix = element
        when Format
          super
        end
      end

    end #end class Seqs

    # = DESCRIPTION
    # Abstract <em>characters</em> implementation of <em>AbstractCells</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractCells] type.
    # This class defines <tt>matrix</tt> attribute accessor but not writer. A concrete subclass must define a <tt>matrix=</tt> attribute accessor. Since this class 
    # inherits from Bio::NeXML::Characters a <tt>format=</tt> method must also be defined by a concrete subclass.
    # Following classes extend Bio::NeXML::Cells:
    # * Bio::NeXML::ProteinCells
    # * Bio::NeXML::DnaCells
    # * Bio::NeXML::RnaCells
    # * Bio::NeXML::RestrictionCells
    # * Bio::NeXML::ContinuousCells
    # * Bio::NeXML::StandardCells
    class Cells < Characters

      attr_reader :matrix

      def initialize( id, otus, label = nil )
        super
      end

      # Abstract method. Add a <em>format</em> or a <em>matrix</em> element to <tt>self</tt>.
      # It calls the <tt>format=</tt> or <tt>matrix=</tt> method of its concrete subtype
      # to do so.
      # ---
      # *Arguments*
      # * element( required ) - a Bio::NeXML::Format or a Bio::NeXML::CellMatrix object.
      def <<( element )
        case element
        when Matrix
          raise InvalidMatrixException, "CellMatrix expected." unless element.kind_of? CellMatrix
          self.matrix = element
        when Format
          super
        end
      end

    end #end class Cells

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of <em>DnaSeqs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DnaSeqs] type.
    class DnaSeqs < Seqs

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::DnaFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "DnaFormat expected." unless format.instance_of? DnaFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::DnaSeqMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "DnaSeqMatrix expected." unless matrix.instance_of? DnaSeqMatrix
        @matrix = matrix
      end

    end #end class DnaSeqs

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>RnaSeqs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RnaSeqs] ) type.
    class RnaSeqs < Seqs

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::RnaFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "RnaFormat expected" unless format.instance_of? RnaFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::RnaSeqMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "RnaSeqMatrix expected." unless matrix.instance_of? RnaSeqMatrix
        @matrix = matrix
      end

    end #end class RnaSeqs

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>RestrictionSeqs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionSeqs] ) type.
    class RestrictionSeqs < Seqs

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::RestrictionFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "RestrictionFormat expected" unless format.instance_of? RestrictionFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::RestrictionSeqMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "RestrictionSeqMatrix expected." unless matrix.instance_of? RestrictionSeqMatrix
        @matrix = matrix
      end

    end #end class RestrictionSeqs

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>ProteinSeqs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#ProteinSeqs] ) type.
    class ProteinSeqs < Seqs

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::ProteinFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "ProteinFormat expected" unless format.instance_of? ProteinFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::ProteinSeqMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "ProteinSeqMatrix expected." unless matrix.instance_of? ProteinSeqMatrix
        @matrix = matrix
      end

    end #end class ProteinSeqs

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>StandardSeqs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardSeqs] ) type.
    class StandardSeqs < Seqs

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::StandardFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "StandardFormat expected" unless format.instance_of? StandardFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::StandardSeqMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "StandardSeqMatrix expected." unless matrix.instance_of? StandardSeqMatrix
        @matrix = matrix
      end

    end #end class StandardSeqs

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>ContinuousSeqs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousSeqs] ) type.
    class ContinuousSeqs < Seqs

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::ContinuousFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "ProteinFormat expected" unless format.instance_of? ContinuousFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::ContinuousSeqMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "ContinuousSeqMatrix expected." unless matrix.instance_of? ContinuousSeqMatrix
        @matrix = matrix
      end

    end #end class ContinuousSeqs

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>DnaCells</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DnaCells] ) type.
    class DnaCells < Cells

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::DnaFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "DnaFormat expected" unless format.instance_of? DnaFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::DnaCellMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "DnaCellMatrix expected." unless matrix.instance_of? DnaCellMatrix
        @matrix = matrix
      end

    end #end class DnaCells

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>RnaCells</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RnaCells] ) type.
    class RnaCells < Cells

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::RnaFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "RnaFormat expected." unless format.instance_of? RnaFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::RnaCellMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "RnaCellMatrix expected." unless matrix.instance_of? RnaCellMatrix
        @matrix = matrix
      end

    end #end class RnaCells

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>RestrictionCells</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionCells] ) type.
    class RestrictionCells < Cells

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::RestrictionFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "RestrictionFormat expected" unless format.instance_of? RestrictionFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::RestrictionCellMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "RestrictionCellMatrix expected." unless matrix.instance_of? RestrictionCellMatrix
        @matrix = matrix
      end

    end #end class RestrictionCells

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>ProteinCells</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#ProteinCells] ) type.
    class ProteinCells < Cells

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::ProteinFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "ProteinFormat expected" unless format.instance_of? ProteinFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::ProteinCellMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "ProteinCellMatrix expected." unless matrix.instance_of? ProteinCellMatrix
        @matrix = matrix
      end

    end #end class ProteinCells

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>StandardCells</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardCells] ) type.
    class StandardCells < Cells

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::StandardFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "StandardFormat expected" unless format.instance_of? StandardFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::StandardCellMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "StandardCellMatrix expected." unless matrix.instance_of? StandardCellMatrix
        @matrix = matrix
      end

    end #end class StandardCells

    # = DESCRIPTION
    # Concrete <em>characters</em> implementation of ( <em>ContinuousCells</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousCells] ) type.
    class ContinuousCells < Cells

      def initialize( id, otus, label = nil )
        super
      end

      # Add a <em>format</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * format( required ) - a Bio::NeXML::ContinuousFormat object.
      # *Raises*
      # * Bio::NeXML::InvalidFormatException - if format is not of the correct type.
      def format=( format )
        raise InvalidFormatException, "ProteinFormat expected" unless format.instance_of? ContinuousFormat
        @format = format
      end

      # Add a <em>matrix</em> element to <tt>self</tt>.
      # ---
      # *Arguments*
      # * matrix( required ) - a Bio::NeXML::ContinuousCellMatrix object.
      # *Raises*
      # * Bio::NeXML::InvalidMatrixException - if matrix is not of the correct type.
      def matrix=( matrix )
        raise InvalidMatrixException, "ContinuousCellMatrix expected." unless matrix.instance_of? ContinuousCellMatrix
        @matrix = matrix
      end

    end #end class ContinuousCells

    # = DESCRIPTION
    # Abstract <em>format</em> implementation of <em>AbstractFormat</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractFormat] type.
    # This class defines methods for storage and retreival of <em>states</em> or <em>char</em> elements. However, at the lowest level it calls
    # <tt>add_states</tt> and <tt>add_char</tt> method of its concrete subtype to do so. Naturally, a concrete subtype must define these methods.
    # Bio::NeXML::Format has the following subclasses:
    # * Bio::NeXML::ProteinFormat
    # * Bio::NeXML::DnaFormat
    # * Bio::NeXML::RnaFormat
    # * Bio::NeXML::ContinuousFormat
    # * Bio::NeXML::RestrictionFormat
    # * Bio::NeXML::StandardFormat
    class Format
      include Enumerable

      # Abstract method. Add one or more <em>states</em> or <em>char</em> elements to <tt>self</tt>.
      # Detects the type of argument and delegates the addition to <tt>states=</tt> or <tt>chars=</tt> methods.
      # ---
      # *Arguments*:
      # * elements( required ) - one or more( comma seperated ) Bio::NeXML::States or Bio::NeXML::Char objects.
      def <<( elements )
        test = elements.instance_of?( Array ) ? elements.first : elements
        case test
        when States
          self.states = elements
        when Char
          self.chars = elements
        end
      end

      # Provide a hash storage for <em>states</em> element.
      # ---
      # *Returns*: a hash of Bio::NeXML::States objects or an empty hash
      # if none exist.
      def states_set
        @states_set ||= {}
      end

      # Provide a hash storage for Bio::NeXML::Char object.
      # ---
      # *Returns*: a hash of Bio::NeXML::Char objects or an empty hash
      # if none exist.
      def char_set
        @char_set ||= {}
      end

      # *Returns*: an array of Bio::NeXML::States objects.
      def states
        states_set.values
      end

      # *Returns*: an array of Bio::NeXML::Char objects.
      def chars
        char_set.values
      end

      # Abstract method. Add <em>states</em> elements to <tt>self</tt>.
      # Internally it calls the <tt>add_states</tt> method of its concrete subtype to add an idividual <em>states</em> element.
      # ---
      # *Arguments*:
      # * states( required ) - one or more( comma seperated ) Bio::NeXML::States objects.
      def states=( states )
        if states.instance_of?( Array )
          states.each { |ss| add_states( ss ) }
        else
          add_states( states )
        end
      end

      # Abstract method. Add <em>char</em> elements to <tt>self</tt>.
      # Internally it calls the <tt>add_char</tt> method of its concrete subtype to add an idividual <em>char</em> element.
      # ---
      # *Arguments*:
      # * chars( required ) - one or more( comma seperated ) Bio::NeXML::Char objects.
      def chars=( chars )
        if chars.instance_of? Array
          chars.each { |char| add_char( char ) }
        else
          add_char( chars )
        end
      end

      # Find a <em>states</em> element by id.
      # ---
      # *Arguments*:
      # * id( required ) - id of the <em>states</em> element to be found.
      # *Returns*: the <em>states</em> element if found, nil otherwise.
      def get_states_by_id( id )
        states_set[ id ]
      end

      # Find a <em>char</em> element by id.
      # ---
      # *Arguments*:
      # * id( required ) - id of the <em>char</em> element to be found.
      # *Returns*: the <em>char</em> element if found, nil otherwise.
      def get_char_by_id( id )
        char_set[ id ]
      end

      # Access <em>states</em> and <em>char</em> using the hash notation.
      # ---
      # *Arguments*:
      # * id( required ) - id of the <em>states</em> or the <em>char</em> element to be accessed.
      # *Returns*: the <em>states</em> or the <em>char</em> element if found, nil otherwise.
      def []( id )
        char_set[ id ] or states_set[ id ]
      end

      # Determine if a <em>states</em> element belongs to this object.
      # ---
      # *Arguments*:
      # * id( required ) - id of the <em>states</em> element to be checked.
      # *Returns*: true if the <em>states</em> element is found, false otherwise.
      def has_states?( id )
        states_set.has_key? id
      end

      # Determine if a <em>char</em> element belongs to this object.
      # ---
      # *Arguments*:
      # * id( required ) - id of the <em>char</em> element to be checked.
      # *Returns*: true if the <em>char</em> element is found, false otherwise.
      def has_char?( id )
        char_set.has_key? id
      end

      # Determine if a <em>states</em> or a <em>char</em> element belongs to this object.
      # ---
      # *Arguments*:
      # * id( required ) - id of the <em>states</em> or the <em>char</em> element to be checked.
      # *Returns*: true if the <em>states</em> or the <em>char</em> element is found, false otherwise.
      def has?( id )
        has_states?( id ) or has_char?( id )
      end
      alias include? has?

      # Call the block for each <em>states</em> element in <tt>self</tt> passing that object as
      # a parameter.
      def each_states
        states_set.each_value do |states|
          yield states
        end
      end

      # Call the block for each <em>char</em> element in <tt>self</tt> passing that object as
      # a parameter.
      def each_char
        char_set.each_value do |char|
          yield char
        end
      end

      # Call the block for each <em>states</em> and <em>char</em> element in <tt>self</tt> passing that object as
      # a parameter.
      def each
        states_set.each_value do |states|
          yield states
        end
        char_set.each_value do |char|
          yield char
        end
      end

    end #end class Format

    # = DESCRIPTION
    # Concrete <em>format</em> implementation of <em>AAFormat</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAFormat] type.
    class ProteinFormat < Format
      
      def initialize( states = nil, char = nil )
        self << states
        self << char
      end

      # Add a single <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::ProteinStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def add_states( states )
        raise InvalidStatesException, "ProteinStates expected" unless states.instance_of? ProteinStates
        states_set[ states.id ] = states
      end

      # Add a single <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) - a Bio::NeXML::ProteinChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if states is not of the correct type.
      def add_char( char )
        raise InvalidCharException, "ProteinChar expected" unless states.instance_of? ProteinChar
        char_set[ char.id ] = char
      end

    end

    # = DESCRIPTION
    # Concrete <em>format</em> implementation of <em>ContinuousFormat</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#ContinuousFormat] type.
    class ContinuousFormat < Format

      def initialize( char = nil )
        self << char
      end

      # Add a single <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) - a Bio::NeXML::ContinuousChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if states is not of the correct type.
      def add_char( char )
        raise InvalidCharException, "ContinuousChar expected" unless char.instance_of? ContinuousChar
        char_set[ char.id ] = char
      end

    end

    # = DESCRIPTION
    # Concrete <em>format</em> implementation of <em>DnaFormat</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#DNAFormat] type.
    class DnaFormat < Format

      def initialize( states = nil, char = nil )
        self << states
        self << char
      end

      # Add a single <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::DnaStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def add_states( states )
        raise InvalidStatesException, "DnaStates expected" unless states.instance_of? DnaStates
        states_set[ states.id ] = states
      end

      # Add a single <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) - a Bio::NeXML::DnaChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if states is not of the correct type.
      def add_char( char )
        raise InvalidCharException, "DnaChar expected" unless char.instance_of? DnaChar
        char_set[ char.id ] = char
      end

    end

    # = DESCRIPTION
    # Concrete <em>format</em> implementation of <em>RnaFormat</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#RNAFormat] type.
    class RnaFormat < Format

      def initialize( states = nil, char = nil )
        self << states
        self << char
      end
      
      # Add a single <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::RnaStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def add_states( states )
        raise InvalidStatesException, "RnaStates expected" unless states.instance_of? RnaStates
        states_set[ states.id ] = states
      end

      # Add a single <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) - a Bio::NeXML::RnaChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if states is not of the correct type.
      def add_char( char )
        raise InvalidCharException, "RnaChar expected" unless char.instance_of? RnaChar
        char_set[ char.id ] = char
      end

    end

    # = DESCRIPTION
    # Concrete <em>format</em> implementation of <em>RestrictionFormat</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#RestrictionFormat] type.
    class RestrictionFormat < Format

      def initialize( states = nil, char = nil )
        self << states
        self << char
      end

      # Add a single <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::RestrictionStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def add_states( states )
        raise InvalidStatesException, "RestrictionStates expected" unless states.instance_of? RestrictionStates
        states_set[ states.id ] = states
      end

      # Add a single <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) - a Bio::NeXML::RestrictionChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if states is not of the correct type.
      def add_char( char )
        raise InvalidCharException, "RestrictionChar expected" unless char.instance_of? RestrictionChar
        char_set[ char.id ] = char
      end

    end

    # = DESCRIPTION
    # Concrete <em>format</em> implementation of <em>StandardFormat</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#StandardFormat] type.
    class StandardFormat < Format

      def initialize( states = nil, char = nil )
        self << states
        self << char
      end

      # Add a single <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::StandardStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def add_states( states )
        raise InvalidStatesException, "StandardStates expected" unless states.instance_of? StandardStates
        states_set[ states.id ] = states
      end

      # Add a single <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) - a Bio::NeXML::StandardChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if states is not of the correct type.
      def add_char( char )
        raise InvalidCharException, "StandardChar expected" unless char.instance_of? StandardChar
        char_set[ char.id ] = char
      end

    end

    # = DESCRIPTION
    # Abstract <em>states</em> implementation of <em>AbstractStates</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractStates] type.
    # This class defines methods for storage and retreival of <em>state</em> elements. However, at the lowest level it calls <tt>add_state</tt> method of its concrete subtype to do so.
    # Naturally, a concrete subtype must define <tt>add_state</tt> method.
    # Following classes inherit from Bio::NeXML::States:
    # * Bio::NeXML::ProteinStates
    # * Bio::NeXML::RnaStates
    # * Bio::NeXML::DnaStates
    # * Bio::NeXML::RestrictionStates
    # * Bio::NeXML::StandardStates
    class States
      include IDTagged
      include Enumerable
      
      def initialize( id, label = nil )
        @id = id
        @label = label
      end

      # Provide a hash storage for Bio::NeXML::State object.
      # ---
      # *Returns*: a hash of Bio::NeXML::State objects or an empty hash
      # if none exist.
      def state_set
        @state_set ||= {}
      end

      # *Returns*: an array of Bio::NeXML::State objects.
      def states
        state_set.values
      end

      # Abstract method. Add <em>state</em> elements to <tt>self</tt>.
      # It calls <tt>add_state</tt> method of its concrete subtype to add each <em>state</em> element.
      # ---
      # *Arguments*:
      # * a comman seperated list of Bio::NeXML::State objects.
      def states=( states )
        if states.instance_of? Array
          states.each do |state|
            add_state( state )
          end
        else
          add_state( states )
        end
      end
      alias << states=

      #Return an Bio::NeXML::State object with the given id or nil.
      def get_state_by_id( id )
        state_set[ id ]
      end
      alias [] get_state_by_id

      # Determine if a <em>state</em> element belongs to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * id( required ) - id of the <em>state</em> element to be checked.
      # *Returns*: true if the <em>state</em> element is found, false otherwise.
      def has_state?( id )
        state_set.has_key? id
      end
      alias :include? :has_state?
      alias :has? :has_state?

      # Call the block for each <em>state</em> element in <tt>self</tt> passing that object as
      # a parameter to the block.
      def each
        state_set.each_value{ |state| yield state }
      end
      alias each_state each

    end #end class States

    # = DESCRIPTION
    # Concrete <em>states</em> implementation of <em>AAStates</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAStates] type.
    class ProteinStates < States

      def initialize( id, label = nil )
        super
      end
      
      # Add a single <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::ProteinState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if states is not of the correct type.
      def add_state( state )
        raise InvalidStateException, "ProteinState expected." unless state.instance_of? ProteinState
        state_set[ state.id ] = state
      end

    end #end class ProteinStates

    # = DESCRIPTION
    # Concrete <em>states</em> implementation of <em>DNAStates</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNAStates] type.
    class DnaStates < States

      def initialize( id, label = nil )
        super
      end

      # Add a single <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::DnaState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if states is not of the correct type.
      def add_state( state )
        raise InvalidStateException, "DnaState expected." unless state.instance_of? DnaState
        state_set[ state.id ] = state
      end
      
    end #end class DnaStates

    # = DESCRIPTION
    # Concrete <em>states</em> implementation of <em>RNAStates</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNAStates] type.
    class RnaStates < States

      def initialize( id, label = nil )
        super
      end
      
      # Add a single <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::RnaState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if states is not of the correct type.
      def add_state( state )
        raise InvalidStateException, "RnaState expected." unless state.instance_of? RnaState
        state_set[ state.id ] = state
      end
      
    end #end class RnaStates

    # = DESCRIPTION
    # Concrete <em>states</em> implementation of <em>RestrictionStates</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionStates] type.
    class RestrictionStates < States

      def initialize( id, label = nil )
        super
      end
      
      # Add a single <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::RestrictionState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if states is not of the correct type.
      def add_state( state )
        raise InvalidStateException, "RestrictionState expected." unless state.instance_of? RestrictionState
        state_set[ state.id ] = state
      end
      
    end #end class RestrictionStates

    # = DESCRIPTION
    # Concrete <em>states</em> implementation of <em>StandardStates</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard./#StandardStates] type.
    class StandardStates < States

      def initialize( id, label = nil )
        super
      end
      
      # Add a single <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::StandardState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if states is not of the correct type.
      def add_state( state )
        raise InvalidStateException, "StandardState expected." unless state.instance_of? StandardState
        state_set[ state.id ] = state
      end
      
    end #end class StandardStates

    # =DESCRIPTION
    # Mixin. Allows a <em>state</em> to be amiguous.
    module Ambiguous
      include Enumerable
      attr_writer :polymorphic, :uncertain

      # Add members to the state. It delegated the actual addition to <tt>add_member</tt> method.
      # ---
      # *Arguments*:
      # * states( required ) - one or more( comma seperated ) objects of type <tt>self</tt>.
      def <<( states )
        if states.instance_of? Array
          states.each{ |state| add_member state }
        else
          add_member states
        end
      end
      alias members= <<

      # Add a member to <tt>self</tt>
      # ---
      # *Arguments*:
      # * state( required ) - an object of type <tt>self</tt>.
      # *Raises*:
      # * Bio::NeXML::InvalidMemberException - if state is of incorrect type.
      def add_member( state )
        raise InvalidMemberException, "#{self.class} expected" unless state.instance_of? self.class
        members << state
      end

      # *Returns*: true if the state is polymorphic, false otherwise.
      def polymorphic?
        @polymorphic ? true : false
      end

      # *Returns*: true if the state is uncertain, false otherwise.
      def uncertain?
        @uncertain ? true : false
      end

      # *Returns*: a string stating the kind of ambiguity: polymorphic or uncertain.
      def ambiguity
        return :polymorphic if polymorphic?
        return :uncertain if uncertain?
      end

      # *Returns*: true if the state is ambiguous, false otherwise.
      def ambiguous?
        polymorphic? or uncertain?
      end

      # Provide an array storage for ambiguity mapping.
      # ---
      # *Returns*: an array of members or empty array if none exist.
      def members
        @members ||= []
      end

      # Call the block for each <em>member</em> element in <tt>self</tt> passing that object as
      # a parameter to the block.
      def each
        members.each{ |member| yield member }
      end
      alias each_member each

    end

    # = DESCRIPTION
    # Abstract <em>state</em> implementation of <em>StandardState</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractState] type.
    # This class defines <tt>symbol</tt> attribute reader but not the attribute writer, so, a concrete subtype must define a <tt>symbol=</tt> attribute writer.
    # Following are the subclasses of Bio::NeXML::State:
    # * Bio::NeXML::ProteinState
    # * Bio::NeXML::DnaState
    # * Bio::NeXML::RnaState
    # * Bio::NeXML::StandardState
    # * Bio::NeXML::RestrictionState
    class State
      include IDTagged
      include Ambiguous
      attr_reader :symbol

      def initialize( id, symbol = nil, label = nil )
        @id = id
        @label = label
        self.symbol = symbol if symbol
      end

    end #enc class State

    # = DESCRIPTION
    # Concrete <em>state</em> implementation of <em>AAState</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAState] type.
    class ProteinState < State

      def initialize( id, symbol, label = nil )
        super
      end

      # Assign a symbol to <tt>self</tt>
      # ---
      # *Arguments*:
      # * symbol( required ) - a Protein( or amino acid ) token.
      # *Raises*:
      # * Bio::NeXML::InvalidTokenException - if symbol is not valid.
      def symbol=( symbol )
        raise InvalidTokenException, "Not a valid Protein token." unless symbol =~ /[\*\-\?ABCDEFGHIKLMNPQRSTUVWXYZ]/
        @symbol = symbol
      end

    end

    # = DESCRIPTION
    # Concrete <em>state</em> implementation of <em>DNAState</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNAState] type.
    class DnaState < State

      def initialize( id, symbol, label = nil )
        super
      end

      # Assign a symbol to <tt>self</tt>
      # ---
      # *Arguments*:
      # * symbol( required ) - a DNA token.
      # *Raises*:
      # * Bio::NeXML::InvalidTokenException - if symbol is not valid.
      def symbol=( symbol )
        raise InvalidTokenException, "Not a valid DNA token." unless symbol =~ /[ABCDGHKMNRSTVWXY\-\?]/
        @symbol = symbol
      end

    end

    # = DESCRIPTION
    # Concrete <em>state</em> implementation of <em>RNAState</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNAState] type.
    class RnaState < State

      def initialize( id, symbol, label = nil )
        super
      end

      # Assign a symbol to <tt>self</tt>
      # ---
      # *Arguments*:
      # * symbol( required ) - a RNA token.
      # *Raises*:
      # * Bio::NeXML::InvalidTokenException - if symbol is not valid.
      def symbol=( symbol )
        raise InvalidTokenException, "Not a valid RNA token." unless symbol =~ /[\-\?ABCDGHKMNRSUVWXY]/
        @symbol = symbol
      end

    end

    # = DESCRIPTION
    # Concrete <em>state</em> implementation of <em>RestrictionState</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionState] type.
    class RestrictionState < State

      def initialize( id, symbol, label = nil )
        super
      end

      # Assign a symbol to <tt>self</tt>
      # ---
      # *Arguments*:
      # * symbol( required ) - a Restriction token.
      # *Raises*:
      # * Bio::NeXML::InvalidTokenException - if symbol is not valid.
      def symbol=( symbol )
        raise InvalidTokenException, "Not a valid Restriction token." unless symbol =~ /0|1/
        @symbol = symbol.to_i
      end

    end

    # = DESCRIPTION
    # Concrete <em>state</em> implementation of <em>StandardState</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardState] type.
    class StandardState < State

      def initialize( id, symbol, label = nil )
        super
      end

      # Assign a symbol to <tt>self</tt>
      # ---
      # *Arguments*:
      # * symbol( required ) - a Standard token.
      # *Raises*:
      # * Bio::NeXML::InvalidTokenException - if symbol is not valid.
      def symbol=( symbol )
        raise InvalidTokenException, "Not a valid Standard token." unless symbol =~ /^\d$/
        @symbol = symbol.to_i
      end

    end

    # = DESCRIPTION
    # This module makes <em>codon</em> attribute available to Bio::NeXML::DnaChar and Bio::NeXML::RnaChar objects.
    module Codon
      attr_reader :codon
      alias codon_position codon

      # Assign a codon position to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * cp( required ) - a valid codon position.
      # *Raises*:
      # * Bio::NeXML::InvalidCodonPositionException - if cp is not a valid codon postion.
      def codon=( cp )
        raise InvalidCodonPositionException, "Valid codon position expected." unless cp =~ /[123]/
        cp = cp.to_i
        @codon = cp
      end
      alias codon_position= codon=

    end

    # = DESCRIPTION
    # Abstract <em>char</em> implementation of <em>AbstractChar</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractChar] type.
    # This class defines <tt>states</tt> attribute accessor but not writer, so a concrete subtype must define it.
    # Bio::NeXML::Char has the following subtypes:
    # * Bio::NeXML::ProteinChar
    # * Bio::NeXML::DnaChar
    # * Bio::NeXML::RnaChar
    # * Bio::NeXML::RestrictionChar
    # * Bio::NeXML::StandardChar
    # * Bio::NeXML::ContinuousChar
    class Char
      include IDTagged
      attr_reader :states
      
      def initialize( id, states = nil, label = nil )
        @id = id
        @label = label 
        self.states = states if states
      end

    end

    # = DESCRIPTION
    # Concrete <em>char</em> implementation of <em>AAChar</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAChar] type.
    class ProteinChar < Char

      def initialize( id, states, label = nil )
        super
      end

      # Add a <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::ProteinStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def states=( states )
        raise InvalidStatesException, "ProteinStates expected" unless states.instance_of? ProteinStates
        @states = states
      end

    end

    # = DESCRIPTION
    # Concrete <em>char</em> implementation of <em>DNAChar</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNAChar] type.
    class DnaChar < Char
      include Codon

      def initialize( id, states, label = nil )
        super
      end

      # Add a <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::DnaStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def states=( states )
        raise InvalidStatesException, "DnaStates expected" unless states.instance_of? DnaStates
        @states = states
      end

    end

    # = DESCRIPTION
    # Concrete <em>char</em> implementation of <em>RNAChar</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNAChar] type.
    class RnaChar < Char
      include Codon

      def initialize( id, states, label = nil )
        super
      end

      # Add a <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::RnaStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def states=( states )
        raise InvalidStatesException, "RnaStates expected" unless states.instance_of? RnaStates
        @states = states
      end

    end
    
    # = DESCRIPTION
    # Concrete <em>char</em> implementation of <em>RestrictionChar</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionChar] type.
    class RestrictionChar < Char

      def initialize( id, states, label = nil )
        super
      end

      # Add a <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::RestrictionStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def states=( states )
        raise InvalidStatesException, "RestrictionStates expected" unless states.instance_of? RestrictionStates
        @states = states
      end

    end

    # = DESCRIPTION
    # Concrete <em>char</em> implementation of <em>ContinuousChar</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousChar] type.
    class ContinuousChar < Char

      def initialize( id, states = nil, label = nil )
        super
      end

    end

    # = DESCRIPTION
    # Concrete <em>char</em> implementation of <em>StandardChar</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardChar] type.
    class StandardChar < Char

      def initialize( id, states, label = nil )
        super
      end

      # Add a <em>states</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * states( required ) - a Bio::NeXML::StandardStates object.
      # *Raises*:
      # * Bio::NeXML::InvalidStatesException - if states is not of the correct type.
      def states=( states )
        raise InvalidStatesException, "StandardStates expected" unless states.instance_of? StandardStates
        @states = states
      end

    end

    # = DESCRIPTION
    # Absctract <em>matrix</em> class. Though this class does not directly represent a class from the schema, it lays down the structure of a <em>matrix</em>
    # including methods for storage and retreival of <em>row</em> elements. However, at the lowest level, it calls the <tt>add_row</tt> method, so a
    # concrete subtype must define it to add a single <em>row</em> element.
    # Following two classes inherit from Bio::NeXML::Matrix:
    # * Bio::NeXML::SeqMatrix
    # * Bio::NeXML::CellMatrix
    class Matrix

      # Provide a hash storage for Bio::NeXML::Row object.
      # ---
      # *Returns*: a hash of Bio::NeXML::Row objects or an empty hash
      # if none exist.
      def row_set
        @row_set ||= {}
      end

      # *Returns*: an array of Bio::NeXML::Row objects.
      def rows
        row_set.values
      end

      # Abstract method. Add one or more <em>row</em> elements to <tt>self</tt>.
      # Internally it calls the <tt>add_row</tt> method of its concrete subtype to add an individual <em>row</em> element.
      # ---
      # *Arguments*:
      # * rows( required ) - one or more ( comma seperated ) list of Bio::NeXML::Row objects.
      def rows=( rows )
        if rows.instance_of? Array
          rows.each do |row|
            add_row( row )
          end
        else
          add_row( rows )
        end
      end
      alias << rows=

      def each_row
        row_set.each_value{ |row| yield row }
      end

    end #end class Matrix

    # = DESCRIPTION
    # Absctract <em>matrix</em> implementation of <em>AbstractSeqMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractSeqMatrix] type.
    # Since this class inherits from Bio::NeXML::Matrix, a concrete subtype must define a <tt>add_row</tt> method.
    # Following are the subclasses of Bio::NeXML::SeqMatrix:
    # * Bio::NeXML::ProteinSeqMatrix
    # * Bio::NeXML::RnaSeqMatrix
    # * Bio::NeXML::DnaSeqMatrix
    # * Bio::NeXML::RestrictionSeqMatrix
    # * Bio::NeXML::ContinuousSeqMatrix
    # * Bio::NeXML::StandardSeqMatrix
    class SeqMatrix < Matrix; end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>AASeqMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AASeqMatrix] type.
    class ProteinSeqMatrix < SeqMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::ProteinSeqRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "ProteinSeqRow expected." unless row.instance_of? ProteinSeqRow
        row_set[ row.id ] = row
      end

    end
  
    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>ContinuousSeqMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousSeqMatrix] type.
    class ContinuousSeqMatrix < SeqMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::ContinuousSeqRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "ContinuousSeqRow expected." unless row.instance_of? ContinuousSeqRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>DNASeqMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNASeqMatrix] type.
    class DnaSeqMatrix < SeqMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::DnaSeqRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "DnaSeqRow expected." unless row.instance_of? DnaSeqRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>RNASeqMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNASeqMatrix] type.
    class RnaSeqMatrix < SeqMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::RnaSeqRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "RnaSeqRow expected." unless row.instance_of? RnaSeqRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>RestrictionSeqMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionSeqMatrix] type.
    class RestrictionSeqMatrix < SeqMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::RestrictionSeqRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "RestrictionSeqRow expected." unless row.instance_of? RestrictionSeqRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>StandardSeqMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardSeqMatrix] type.
    class StandardSeqMatrix < SeqMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::StandardSeqRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "StandardSeqRow expected." unless row.instance_of? StandardSeqRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Abstract <em>matrix</em> implementation of <em>AbstractObsMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractObsMatrix] type.
    # Since this class inherits from Bio::NeXML::Matrix, a concrete subtype must define a <tt>add_row</tt> method.
    # Following are the subclasses of Bio::NeXML::CellMatrix
    # * Bio::NeXML::ProteinCellMatrix
    # * Bio::NeXML::RnaCellMatrix
    # * Bio::NeXML::DnaCellMatrix
    # * Bio::NeXML::RestrictionCellMatrix
    # * Bio::NeXML::ContinuousCellMatrix
    # * Bio::NeXML::StandardCellMatrix
    class CellMatrix < Matrix; end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>AAObsMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAObsMatrix] type.
    class ProteinCellMatrix < CellMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::ProteinCellRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "ProteinCellRow expected." unless row.instance_of? ProteinCellRow
        row_set[ row.id ] = row
      end

    end
    
    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>DNAObsMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNAObsMatrix] type.
    class DnaCellMatrix < CellMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::DnaCellRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "DnaCellRow expected." unless row.instance_of? DnaCellRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>RNAObsMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNAObsMatrix] type.
    class RnaCellMatrix < CellMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::RnaCellRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "RnaCellRow expected." unless row.instance_of? RnaCellRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>StandardObsMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardObsMatrix] type.
    class StandardCellMatrix < CellMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::StandardCellRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "StandardCellRow expected." unless row.instance_of? StandardCellRow
        row_set[ row.id ] = row
      end

    end
    
    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>ContinuousObsMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousObsMatrix] type.
    class ContinuousCellMatrix < CellMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::ContinuousCellRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "ContinuousCellRow expected." unless row.instance_of? ContinuousCellRow
        row_set[ row.id ] = row
      end

    end

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>RestrictionObsMatrix</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionObsMatrix] type.
    class RestrictionCellMatrix < CellMatrix

      # Add a <em>row</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * row( requried ) - a Bio::NeXML::RestrictionCellRow object.
      # *Raises*:
      # * Bio::NeXML::InvalidRowException - if row is of incorrect type.
      def add_row( row )
        raise InvalidRowException, "RestrictionCellRow expected." unless row.instance_of? RestrictionCellRow
        row_set[ row.id ] = row
      end

    end

    # Abstract <em>row</em> implementation. This class does not directly represent any class from the schema. 
    # Rather, it lays out the structure of a <em>row</em> object. Follwing classes inherit from Bio::NeXML::Row:
    # * Bio::NeXML::SeqRow
    # * Bio::NeXML::CellRow
    class Row
      include TaxonLinked
      include Enumerable

      def initialize( id, otu = nil, label = nil )
        @id = id
        @otu = otu
        @label = label
      end

      # Array of row elements.
      def elements
        @elements ||= []
      end

      # Iterate over each element of the row.
      def each
        elements.each{ |e| yield e }
      end
      alias each_element each

    end #end class Row

    # Abstract <em>row</em> implementation of <em>AbstractSeqRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractSeqRow] type.
    # This class defines <tt>seq</tt> attribute accessor but no attribute writer. A concrete subtype must define <tt>seq=</tt> attribute writer.
    # Bio::NeXML::SeqRow has the following subclasses:
    # * Bio::NeXML::DnaSeqRow
    # * Bio::NeXML::RnaSeqRow
    # * Bio::NeXML::ContinuousSeqRow
    # * Bio::NeXML::RestrictionSeqRow
    # * Bio::NeXML::StandardSeqRow
    # * Bio::NeXML::ProteinSeqRow
    class SeqRow < Row
      attr_reader :seq

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Abstract method. Add a <em>seq</em> to <tt>self</tt>. Internally it calls <tt>seq=</tt> method of its subclass.
      # ---
      # *Arguments*:
      # * seq( required ) - a Bio::NeXML::Seq object.
      def <<( seq )
        self.seq = seq
      end

      # *Returns*: the raw value of the sequence it holds.
      def seq_value
        seq.value
      end

    end #end class SeqRow

    # = DESCRIPTION
    # Concrete <em>row</em> implementation of <em>DNAMatrixSeqRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNAMatrixSeqRow] type.
    class DnaSeqRow < SeqRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>seq</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * seq( requried ) - a Bio::NeXML::DnaSeq object.
      # *Raises*:
      # * Bio::NeXML::InvalidSeqException - if seq is of incorrect type.
      def seq=( seq )
        raise InvalidSeqException, "DnaSeq expected." unless seq.instance_of? DnaSeq
        @seq = seq
      end

    end #class DnaSeqRow

    # = DESCRIPTION
    # Concrete <em>row</em> implementation of <em>RNAMatrixSeqRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNAMatrixSeqRow] type.
    class RnaSeqRow < SeqRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>seq</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * seq( requried ) - a Bio::NeXML::RnaSeq object.
      # *Raises*:
      # * Bio::NeXML::InvalidSeqException - if seq is of incorrect type.
      def seq=( seq )
        raise InvalidSeqException, "RnaSeq expected." unless seq.instance_of? RnaSeq
        @seq = seq
      end

    end

    # = DESCRIPTION
    # Concrete <em>row</em> implementation of <em>AAMatrixSeqRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAMatrixSeqRow] type.
    class ProteinSeqRow < SeqRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>seq</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * seq( requried ) - a Bio::NeXML::ProteinSeq object.
      # *Raises*:
      # * Bio::NeXML::InvalidSeqException - if seq is of incorrect type.
      def seq=( seq )
        raise InvalidSeqException, "ProteinSeq expected." unless seq.instance_of? ProteinSeq
        @seq = seq
      end

    end #end class ProteinSeqRow

    # = DESCRIPTION
    # Concrete <em>row</em> implementation of <em>StandardMatrixSeqRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardMatrixSeqRow] type.
    class StandardSeqRow < SeqRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>seq</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * seq( requried ) - a Bio::NeXML::StandardSeq object.
      # *Raises*:
      # * Bio::NeXML::InvalidSeqException - if seq is of incorrect type.
      def seq=( seq )
        raise InvalidSeqException, "StandardSeq expected." unless seq.instance_of? StandardSeq
        @seq = seq
      end

    end #end class StandardSeqRow

    # = DESCRIPTION
    # Concrete <em>row</em> implementation of <em>RestrictionMatrixSeqRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionMatrixSeqRow] type.
    class RestrictionSeqRow < SeqRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>seq</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * seq( requried ) - a Bio::NeXML::RestrictionSeq object.
      # *Raises*:
      # * Bio::NeXML::InvalidSeqException - if seq is of incorrect type.
      def seq=( seq )
        raise InvalidSeqException, "RestrictionSeq expected." unless seq.instance_of? RestrictionSeq
        @seq = seq
      end

    end #end class RestrictionSeqRow

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>ContinuousMatrixSeqRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousMatrixSeqRow] type.
    class ContinuousSeqRow < SeqRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>seq</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * seq( requried ) - a Bio::NeXML::ContinuousSeq object.
      # *Raises*:
      # * Bio::NeXML::InvalidSeqException - if seq is of incorrect type.
      def seq=( seq )
        raise InvalidSeqException, "ContinuousSeq expected." unless seq.instance_of? ContinuousSeq
        @seq = seq
      end

    end #end class ContinuousSeqRow

    # = DESCRIPTION
    # Abstract <em>row</em> implementation of <em>AbstractObsRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractObsRow] type.
    # This class defines methods for storage and retreival of <em>cell</em> elements within a <em>row</em>. However, at the lowest level <tt>add_cell</tt> method is called.
    # Naturally, a concrete subtype must define <tt>add_cell</tt> method to assign a single <em>cell</em> element to <tt>self</tt>.
    # Follwing are the subclass of Bio::NeXML::CellRow:
    # * Bio::NeXML::DnaCellRow
    # * Bio::NeXML::ProteinCellRow
    # * Bio::NeXML::RnaCellRow
    # * Bio::NeXML::StandardCellRow
    # * Bio::NeXML::RestrictionCellRow
    # * Bio::NeXML::ContinuousCellRow
    class CellRow < Row

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Provide an array storage for Bio::NeXML::Cell object.
      # ---
      # *Returns*: an array of Bio::NeXML::Cell objects or an empty array
      # if none exist.
      def cells
        @cells ||= []
      end

      # Abstract method. Add <em>cell</em> elements to <tt>self</tt>.
      # Internally it calls the <tt>add_cell</tt> method of its concrete subtype to add an individual <em>cell</em> element.
      # ---
      # *Arguments*:
      # * cells( required ) - one or more( comma seperated ) Bio::NeXML::Cell objects.
      def cells=( cells )
        if cells.instance_of? Array
          cells.each do |cell|
            add_cell( cell )
          end
        else
          add_cell( cells )
        end
      end
      alias << cells=

      def each_cell
        cells.each { |cell| yield cell }
      end

    end #enc class CellRow

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>DNAMatrixObsRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNAMatrixObsRow] type.
    class DnaCellRow < CellRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>cell</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * cell( requried ) - a Bio::NeXML::DnaCell object.
      # *Raises*:
      # * Bio::NeXML::InvalidCellException - if cell is of incorrect type.
      def add_cell( cell )
        raise InvalidCellException, "DnaCell expected" unless cell.instance_of? DnaCell
        cells << cell
      end

    end #end class DnaCellRow

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>RNAMatrixObsRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNAMatrixObsRow] type.
    class RnaCellRow < CellRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>cell</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * cell( requried ) - a Bio::NeXML::RnaCell object.
      # *Raises*:
      # * Bio::NeXML::InvalidCellException - if cell is of incorrect type.
      def add_cell( cell )
        raise InvalidCellException, "RnaCell expected" unless cell.instance_of? RnaCell
        cells << cell
      end

    end #end class RnaCellRow

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>AAMatrixObsRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAMatrixObsRow] type.
    class ProteinCellRow < CellRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>cell</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * cell( requried ) - a Bio::NeXML::ProteinCell object.
      # *Raises*:
      # * Bio::NeXML::InvalidCellException - if cell is of incorrect type.
      def add_cell( cell )
        raise InvalidCellException, "ProteinCell expected" unless cell.instance_of? ProteinCell
        cells << cell
      end

    end #end class ProteinCellRow

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>ContinuousMatrixObsRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousMatrixObsRow] type.
    class ContinuousCellRow < CellRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>cell</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * cell( requried ) - a Bio::NeXML::ContinuousCell object.
      # *Raises*:
      # * Bio::NeXML::InvalidCellException - if cell is of incorrect type.
      def add_cell( cell )
        raise InvalidCellException, "ContinuousCell expected" unless cell.instance_of? ContinuousCell
        cells << cell
      end

    end #end class ContinuousCellRow

    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>RestrictionMatrixObsRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionMatrixObsRow] type.
    class RestrictionCellRow < CellRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>cell</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * cell( requried ) - a Bio::NeXML::RestrictionCell object.
      # *Raises*:
      # * Bio::NeXML::InvalidCellException - if cell is of incorrect type.
      def add_cell( cell )
        raise InvalidCellException, "RestrictionCell expected" unless cell.instance_of? RestrictionCell
        cells << cell
      end

    end #end class RestrictionCellRow
    
    # = DESCRIPTION
    # Concrete <em>matrix</em> implementation of <em>StandardMatrixObsRow</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardMatrixObsRow] type.
    class StandardCellRow < CellRow

      def initialize( id, otu = nil, label = nil )
        super
      end

      # Add a <em>cell</em> to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * cell( requried ) - a Bio::NeXML::StandardCell object.
      # *Raises*:
      # * Bio::NeXML::InvalidCellException - if cell is of incorrect type.
      def add_cell( cell )
        raise InvalidCellException, "StandardCell expected" unless cell.instance_of? StandardCell
        cells << cell
      end

    end #end class StandardCellRow

    # = DESCRIPTION
    # Absctract <em>cell</em> implementation of <em>AbstractObs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/abstractcharacters/#AbstractObs] type.
    # This class defines <tt>char</tt> and <tt>state</tt> attribute accessors but not the attribute writers.
    # A concrete subtype must define attribute writers <tt>char=</tt> and <tt>state=</tt>.
    # Bio::NeXML::Cell has the following subtypes:
    # * Bio::NeXML::DnaCell
    # * Bio::NeXML::RnaCell
    # * Bio::NeXML::ProteinCell
    # * Bio::NeXML::RestrictionCell
    # * Bio::NeXML::StandardCell
    # * Bio::NeXML::ContinuousCell
    class Cell
      attr_reader :char, :state
    end

    # = DESCRIPTION
    # Concrete <em>cell</em> implementation of <em>DNAObs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/dna/#DNAObs] type.
    class DnaCell < Cell

      # Assign a <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) = a Bio::NeXML::DnaChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if char is not of the correct type.
      def char=( char )
        raise InvalidCharException, "DnaChar expected" unless char.instance_of? DnaChar
        @char = char
      end

      # Assign a <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * state( required ) = a Bio::NeXML::DnaState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if state if not of the correct type.
      def state=( state )
        raise InvalidStateException, "DnaState expected." unless state.instance_of? DnaState
        @state = state
      end
      
    end #end class DnaCell

    # = DESCRIPTION
    # Concrete <em>cell</em> implementation of <em>RNAObs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/rna/#RNAObs] type.
    class RnaCell < Cell

      # Assign a <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) = a Bio::NeXML::RnaChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if char is not of the correct type.
      def char=( char )
        raise InvalidCharException, "RnaChar expected" unless char.instance_of? RnaChar
        @char = char
      end

      # Assign a <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * state( required ) = a Bio::NeXML::RnaState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if state if not of the correct type.
      def state=( state )
        @state = state
        raise InvalidStateException, "RnaState expected." unless state.instance_of? RnaState
      end
      
    end #end class RnaCell

    # = DESCRIPTION
    # Concrete <em>cell</em> implementation of <em>AAObs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/protein/#AAObs] type.
    class ProteinCell < Cell

      # Assign a <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) = a Bio::NeXML::ProteinChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if char is not of the correct type.
      def char=( char )
        raise InvalidCharException, "ProteinChar expected" unless char.instance_of? ProteinChar
        @char = char
      end

      # Assign a <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * state( required ) = a Bio::NeXML::ProteinState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if state if not of the correct type.
      def state=( state )
        raise InvalidStateException, "ProteinState expected" unless state.instance_of? ProteinState
        @state = state
      end
      
    end #end class ProteinCell
    
    # = DESCRIPTION
    # Concrete <em>cell</em> implementation of <em>StandardObs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/standard/#StandardObs] type.
    class StandardCell < Cell

      # Assign a <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) = a Bio::NeXML::StandardChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if char is not of the correct type.
      def char=( char )
        raise InvalidCharException, "StandardChar expected" unless char.instance_of? StandardChar
        @char = char
      end

      # Assign a <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * state( required ) = a Bio::NeXML::StandardState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if state if not of the correct type.
      def state=( state )
        raise InvalidStateException, "StandardState expected" unless state.instance_of? StandardState
        @state = state
      end
      
    end #end class StandardCell

    # = DESCRIPTION
    # Concrete <em>cell</em> implementation of <em>RestrictionObs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/restriction/#RestrictionObs] type.
    class RestrictionCell < Cell

      # Assign a <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) = a Bio::NeXML::RestrictionChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if char is not of the correct type.
      def char=( char )
        raise InvalidCharException, "RestrictionChar expected" unless char.instance_of? RestrictionChar
        @char = char
      end

      # Assign a <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * state( required ) = a Bio::NeXML::RestrictionState object.
      # *Raises*:
      # * Bio::NeXML::InvalidStateException - if state if not of the correct type.
      def state=( state )
        raise InvalidStateException, "RestrictionState expected" unless state.instance_of? RestrictionState
        @state = state
      end
      
    end #end class RestrictionCell

    # = DESCRIPTION
    # Concrete <em>cell</em> implementation of <em>ContinuousObs</em>[http://nexml.org/nexml/html/doc/schema-1/characters/continuous/#ContinuousObs] type.
    class ContinuousCell < Cell

      # Assign a <em>char</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * char( required ) = a Bio::NeXML::ContinuousChar object.
      # *Raises*:
      # * Bio::NeXML::InvalidCharException - if char is not of the correct type.
      def char=( char )
        raise InvalidCharException, "ContinuousChar expected" unless char.instance_of? ContinuousChar
        @char = char
      end

      # Assign a <em>state</em> element to <tt>self</tt>.
      # ---
      # *Arguments*:
      # * state( required ) = string form of float numeric type.
      # *Raises*:
      # * Bio::NeXML::InvalidTokenException - if state if not of the correct type.
      def state=( state )
        raise InvalidTokenException, "ContinuousToken expected" unless state =~ /^[+-]?\d*(\.\d+)?$/
        @state = state
      end
      
    end #end class ContinuousCell

  end #end module NeXML

end #end module Bio