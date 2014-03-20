# Description:
#   Angry citizen
#
# Commands:
#   hubot как дела? - answers to stupid questions

ME = "(bot|Володя|Владимир)[:|,]"

CONFIG = {
  questions: {
    prefixes: ["Какая разница", "А вас ебёт"],
    fuckoffs: ["Отъебитесь", "Не заёбывайте меня", "Идите нахуй", "Заебали"]
  }
}

module.exports = (robot) ->
  # Questions?
  robot.hear RegExp("#{ME}\s*а?\s*(.+)\?$", "i"), (msg) ->
    question = msg.match[2].replace("ты ", "что я ").replace(/\?$/, "").trim()
    prefix = msg.random(CONFIG.questions.prefixes)
    fuckoff = msg.random(CONFIG.questions.fuckoffs)
    msg.send "#{prefix}, #{question}?! #{fuckoff}!"
