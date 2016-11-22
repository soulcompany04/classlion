# 대학교 4개 리스팅
puts "Inserting university data.."
[
    ["서울대학교", "snu", true, "snu.ac.kr"],
    ["성균관대학교", "skku", false, ""],
    ["숭실대학교", "ss", false, ""],
    ["성신여자대학교", "sungshin", false, ""],
].each do |x|
  University.create(local_name: x[0], english_name: x[1], need_activation: x[2], email_domain: x[3])
end

#전공
puts "Inserting major data.."
[
    [1, "경영"],
    [2, "IT"],
    [3, "통계"],
    [4, "미디어커뮤니케이션"],
    [5, "국제통상"]

].each do |x|
  Major.create(id: x[0], name: x[1])
end
#
# #사용자
# puts "Inserting user data.."
#
#    [1, true, "이브이", "admin@snu.ac.kr", 1, "admin", 1],
#    [2, false, "와플스튜디오", "jradoo2@snu.ac.kr",	1, "jradoo2", 1],
#    [3, false, "flyest", "minsu007@snu.ac.kr", 1, "minsu007", 2],
#    [4, false, "korellas", "korellas@snu.ac.kr", 1, "korellas", 3],
#    [5, false, "이소룡", "cjw1213@snu.ac.kr", 1, "cjw1213", 4]
#
# ].each do |x|
#   User.create(id: x[0], is_boy: x[1], nickname: x[2], email: x[3], university_id: x[4], password: x[5], major_id: x[6])
# end
#
# puts "Inserting lecture data.."
# File.read("db/seed_data/lectures.csv").split("\n").each do |line|
#   data = line.strip.split("\t")
#   Lecture.create(
#       id: data[0],
#       name: data[1],
#       code: data[2],
#       university_id: data[3],
#       unit: data[4]
#   )
# end
#
# puts "Inserting professor data.."
# File.read("db/seed_data/professors.csv").split("\n").each do |line|
#   data = line.strip.split("\t")
#   Professor.create(
#       id: data[0],ㄴ
#       name: data[1],
#       university_id: data[2]
#   )
# end
#
# puts "Inserting course data.."
# File.read("db/seed_data/courses.csv").split("\n").each do |line|
#   data = line.strip.split("\t")
#   Course.create(
#       id: data[0],
#       professor_id: data[1],
#       lecture_id: data[2],
#       university_id: data[3]
#   )
# end
#
# puts "Inserting evaluation data.."
# File.read("db/seed_data/evaluations.csv").split("\n").each do |line|
#   data = line.strip.split("\t")
#   Evaluation.create(
#       id: data[0],
#       user_id: data[1],
#       course_id: data[2],
#       point_overall: data[3],
#       body: data[4]
#   )
# end
