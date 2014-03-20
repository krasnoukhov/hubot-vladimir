# Description:
#   Radical citizen
#
# Commands:
#   Слава Україні - bandera is partriotic
#   Слава нации - bandera is partriotic
#   А я легитимный? - bandera is legetimate

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
