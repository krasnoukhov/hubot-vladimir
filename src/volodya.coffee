# Description:
#   Angry citizen

ME = "(bot|Володя|Владимир)[:|,]?"

MATCHES = {
  questions: RegExp("#{ME}\\s*а?\\s*(.+)\\?$", "i"),
  rudeness: RegExp("#{ME}\\s*(пожуй.*говна|ты.*хуй|(иди|пошёл).*(на.?хуй|в жопу))(.*)", "i"),
  itsme: /ето я/,
  pravoslavie: /(^|[\.!?,]\s+)(а можно|можно ли)[^\.]+\?/,
  why: /(^|[\.!?,]\s+)(почему)[^\.]*\?/,
  whois: RegExp("(кто такой|что за)\\s*#{ME}", "i"),
  troll: RegExp("тролл.*\\s*#{ME}", "i"),
  lifenews: RegExp("#{ME}\\s*(ну\\s+)?(чо|че|что|шо|што)\\s+(там)(\\s+у)?\\s+(хохл(ов|ы))\\??", "i"),
  grammar:
    'типо': 'типа',
    'извени': 'извини',
    'извените': 'извините',
    'что-ли': 'что ли'
    'мичеть': 'миня аж трисет'
    'трисет': 'в мичети'
    'трисёт': 'в мичети'
}

REPLIES = {
  questions: {
    prefixes: ["Какая разница", "А вас ебёт"],
    fuckoffs: ["Отъебитесь", "Не заёбывайте меня", "Идите нахуй", "Заебали"]
  }
  rudeness: "не быкуй!",
  itsme: "НЕТ Я!",
  pravoslavie: ["ГРЕШНО!", "НЕТ, БОГ НАКАЖЕТ!", "БОЖЕ УПАСИ!", "ГРЕШНОВАТО!"],
  why: "Зато Крым наш!",
  whois: "Я единственный легитимный бот Володя.",
  troll: "Анус себе потролль, пёс!",
  grammar: "Правильно писать",
  chotam: "А я хуй знает что там у хохлов"
  error: "Отказ вот пришел"
}

CACHE = {
  chotam: []
}

cheerio = require("cheerio")

module.exports = (robot) ->
  # Telegram Commands
  robot.hear "/pidor", (msg) ->
    msg.reply "Нахуя нажал?"

  # Questions?
  robot.hear MATCHES.questions, (msg) ->
    return if MATCHES.pravoslavie.test(msg.match[0])
    return if MATCHES.why.test(msg.match[0])
    return if MATCHES.lifenews.test(msg.match[0])

    question = msg.match[2].replace("ты ", "что я ").replace(/\?$/, "").trim()
    prefix = msg.random(REPLIES.questions.prefixes)
    fuckoff = msg.random(REPLIES.questions.fuckoffs)
    msg.send "#{prefix}, #{question}?! #{fuckoff}!"

  # Rudeness
  robot.hear MATCHES.rudeness, (msg) ->
    msg.reply REPLIES.rudeness

  # It's me
  robot.hear MATCHES.itsme, (msg) ->
    msg.send REPLIES.itsme

  # Pravoslavie
  robot.hear MATCHES.pravoslavie, (msg) ->
    msg.send msg.random(REPLIES.pravoslavie)

  # Why
  robot.hear MATCHES.why, (msg) ->
    msg.send REPLIES.why

  # Whois
  robot.hear MATCHES.whois, (msg) ->
    msg.send REPLIES.whois

  # Troll
  robot.hear MATCHES.troll, (msg) ->
    msg.send REPLIES.troll

  # Grammar
  for mistake, correct of MATCHES.grammar
    robot.hear RegExp("(^|\\s)(#{mistake})(\\s|$)", "i"), (msg) ->
      msg.send "#{REPLIES.grammar} «#{MATCHES.grammar[msg.match[2]]}», @#{msg.message.user.name}"

  # Cho tam
  robot.hear MATCHES.lifenews, (msg) ->
    msg.http("http://lifenews.ru/tag/%D1%83%D0%BA%D1%80%D0%B0%D0%B8%D0%BD%D0%B0").get() (err, res, body) ->
      if err or res.statusCode isnt 200
        msg.send REPLIES.error
        return

      $ = cheerio.load(body)
      posts = $("#news-feed .publication")
      post = null
      i = 0

      while !post
        i += 1
        candidate = $(msg.random(posts))
        guid = candidate.find("a").attr("href")

        if CACHE.chotam.indexOf(guid) == -1
          post = candidate
          CACHE.chotam.push(guid)
        else
          break if i >= posts.length

      if post
        msg.send "http://lifenews.ru#{post.find("a").attr("href")}"
      else
        console.error body
        msg.send REPLIES.chotam
