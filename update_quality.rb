require 'award'

#Completed project for https://github.com/mdx-dev/platform-code-test

def update_quality(awards)
  awards.each do |award|
    non_degrading_award = false
    increasing_award = false
    if award.name == 'Blue First' || award.name == 'Blue Compare' || award.name == 'Blue Distinction Plus'
      non_degrading_award = true
    end
    if award.name == 'Blue First' || award.name == 'Blue Compare'
      increasing_award = true
    end

    if award.quality < 50 && increasing_award == true
      if award.name == 'Blue First'
        process_blue_first(award)
      elsif award.name == 'Blue Compare'
        process_blue_compare(award)
      end
    end

    if non_degrading_award != true && award.quality > 0
      degrade(award)
    end
    if award.name == 'Blue Star' && award.quality > 0
      degrade(award)
    end

    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
  end
end

def process_blue_first(award)
  award.quality += 1
  if award.expires_in <= 0 && award.quality < 50
    award.quality += 1
  end
end

def process_blue_compare(award)
  if award.expires_in > 0 && award.quality < 50
    award.quality += 1
    if award.expires_in < 11 && award.quality < 50
      award.quality += 1
    end
    if award.expires_in < 6 && award.quality < 50
      award.quality += 1
    end
  else
    award.quality = 0
  end
end

def degrade(award)
  award.quality -= 1
  if award.expires_in <1 && award.quality > 0
    award.quality -= 1
  end
end