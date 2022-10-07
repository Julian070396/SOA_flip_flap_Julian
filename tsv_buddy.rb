# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format

  attr_accessor :data

  def take_tsv(tsv)
    tab = "\t"
    newline = "\n"
    has, @data, arr = {}, [], []
    array = tsv.split(newline)
    array.delete_at(0)
    arr = array[0].split(tab)
    array.each do |info|
      value = info.split(tab)
      has = Hash[arr.zip value]
      @data << has
    end
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    flag = false
    keyarray, valuearray, wholevalue = [], [], '' 
    
    @data.each do |unique|
      unique.each do |a, b|
        keyarray << a.to_s if flag == false
        valuearray.push(b.to_s)
      end
      wholevalue = "#{wholevalue}#{valuearray.join("\t")}\n"
      flag = true
      valuearray = []
    end
    "#{keyarray.join("\t")}\n#{wholevalue}"
  end
end
