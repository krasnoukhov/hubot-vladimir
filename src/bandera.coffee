# Description:
#   Radical citizen

module.exports = (robot) ->
  # Patriotic
  robot.hear /(glory|слава)( to)? (ukraine|україні|украине)/i, (msg) ->
    msg.send "Героям слава!"

  # Patriotic
  robot.hear /(glory|слава)( to)?( the)? (nation|нации|нації)/i, (msg) ->
    msg.send "Смерть ворогам!"

  # Legitimate
  robot.hear /legitimate|bandera|легитимный|легітимний|бандера/i, (msg) ->
    msg.send "Я единственный легитимный бот в этом чате."

  # Putin
  robot.hear /putin|путин|huilo|хуйло|птн|пнх/i, (msg) ->
    msg.send msg.random(["Путин всех переиграл!", "Путин ХУЙЛО!"])

  # Prohibit
  robot.hear /запрет|prohibit/i, (msg) ->
    msg.send "Роскомнадзор скоро тебя запретит!"

  # Coincidence
  robot.hear /совпадение\?/i, (msg) ->
    msg.send "НЕ ДУМАЮ!"

  # Both victory and betrayal
  robot.hear /(перемога|зрада)(.*)(перемога|зрада)/i, (msg) ->
    msg.send "Очевидно, что БОРОТЬБА ТРИВАЄ"

  # Victory
  robot.hear /(.*)перемога(.*)/i, (msg) ->
    if msg.match[0].indexOf("зрада") == -1
      msg.send "А я думаю что ЗРАДА"

  # Betrayal
  robot.hear /(.*)зрада(.*)/i, (msg) ->
    if msg.match[0].indexOf("перемога") == -1
      msg.send "А я думаю что ПЕРЕМОГА"

  # Coffee meme
  robot.hear /mustafa|мустафа|коломойский|коломойський|журналист|депутат/i, (msg) ->
    msg.send "Мустафа, кофе идешь пить?"
