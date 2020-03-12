require 'award'
def update_quality(awards)
  awards.each do |award|
    case award.name
    when "Blue Distinction Plus"
      award.quality = 80
    when "Blue First", "Blue Compare"
      case award.expires_in
      when 11..Float::INFINITY
          award.quality = [award.quality + 1, 50].min
      when  6..10
        award.quality = [award.quality + 2, 50].min
      when 0..5
        award.quality = [award.quality + 3, 50].min
      when -Float::INFINITY..-1
        award.quality = 0
      else
        puts "Could not understand #{award.expires_in}"
      end
    when 'Blue Star'
      award.quality = [award.quality - 2, 0].max
    when 'NORMAL ITEM'
      if award.expires_in <= 0
        award.quality = [award.quality - 2, 0].max
      else
        award.quality = [award.quality - 1, 0].max
      end
    else
      "Award #{award} not found"
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
  end
end
