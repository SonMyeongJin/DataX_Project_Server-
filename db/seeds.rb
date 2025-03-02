# 기존 데이터 삭제 (초기화)
Category.destroy_all
Tag.destroy_all

# 기본 카테고리 추가
categories = ["기술", "라이프스타일", "여행"]
categories.each do |category_name|
  Category.create!(name: category_name)
end
puts "✅ 기본 카테고리 #{categories.size}개 생성 완료!"

# 기본 태그 추가
tags = ["Ruby", "Vue.js", "MySQL"]
tags.each do |tag_name|
  Tag.create!(name: tag_name)
end
puts "✅ 기본 태그 #{tags.size}개 생성 완료!"
