db_host     = 'localhost'
db_user     = 'root'
db_pass     = 'Quocminh27!@#'
db_database = 'atm_db'
LOG_FILE    = 'log.txt'
DB = Database.new(db_host, db_user, db_pass, db_database)

=begin
| user  | CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `money` int(11) NOT NULL DEFAULT '100000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci |
=end
