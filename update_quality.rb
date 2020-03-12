require 'award'
def update_quality(awards)
  awards.each do |award|
    case award.name
    when "Blue Distinction Plus"
      award.quality = 80
    when "Blue First", "Blue Compare"
      case expires_in
      when  expires_in <= 10
        award.quality = [award.quality + 2, 50].min
      when expires_in <= 5
        award.quality = [award.quality + 3, 50].min
      when 0
        award.quality = 0
      end
    when 'Blue Star'
      award.quality = [award.quality - 2, 0].max
    when 'NORMAL ITEM'
      if award.expires_in == 0
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

def update_quality1(awards)
  awards.each do |award|
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          award.quality -= 1
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              award.quality -= 1
            end
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
