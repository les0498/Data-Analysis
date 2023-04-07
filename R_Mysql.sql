# 2023년 시즌 컬러 Waterspout의 색조합 좋아요순 상위 5개 
SELECT HexCol1, HexCol2, HexCol3, HexCol4, Popular FROM db_color.likecolor 
WHERE HexCol1 = '7AD1D8' OR HexCol2 = '7AD1D8' OR HexCol3 = '7AD1D8' OR HexCol4 = '7AD1D8' 
ORDER BY Popular  DESC limit 5;

# 2023년 시즌 컬러 Poppy Seed의 색조합 좋아요순 상위 5개
SELECT HexCol1, HexCol2, HexCol3, HexCol4, Popular FROM db_color.likecolor 
WHERE HexCol1 = '58575C' OR HexCol2 = '58575C' OR HexCol3 = '58575C' OR HexCol4 = '58575C' 
ORDER BY Popular  DESC limit 5;

# 2021 팬톤(뉴욕, 런던) 겹치는 컬러 
SELECT colorname,hexcode,cv, SYMBOL, COUNT(Hexcode),count(colorname),count(cv) FROM ds_color.rn2021
GROUP BY Hexcode
HAVING COUNT(Hexcode) > 1;

# 2023 팬톤(뉴욕, 런던) 겹치는 컬러 
SELECT colorname,Hexcode,cv, SYMBOL, COUNT(Hexcode),count(colorname),count(cv) FROM ds_color.rn2223
GROUP BY Hexcodelikecolorrn2021likecolorHexCol1HexCol4rn2223Popularseasoncolor
HAVING COUNT(Hexcode) > 1;

# 2023 예상 컬러색 뽑기 
SELECT * FROM ds_color.seasoncolor;
SELECT colorname,Hexcode,color, SYMBOL FROM ds_color.rn2223
WHERE color ='BLUE' OR color='GRAY';

# 2021 예상 컬러색 뽑기 
SELECT * FROM ds_color.seasoncolor;
SELECT colorname,Hexcode,color, SYMBOL FROM ds_color.rn2223
WHERE color ='YELLOW' OR color='GRAY'
