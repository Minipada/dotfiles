# Sample Maid rules file -- some ideas to get you started.
#
# To use, remove ".sample" from the filename, and modify as desired.  Test using:
#
#     maid clean -n
#
# **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing
# what they do, you might run into unwanted results!
#
# Don't forget, it's just Ruby!  You can define custom methods and use them below:
# 
#     def magic(*)
#       # ...
#     end
# 
# If you come up with some cool tools of your own, please send me a pull request on GitHub!  Also, please consider sharing your rules with others via [the wiki](https://github.com/benjaminoakes/maid/wiki).
#
# For more help on Maid:
#
# * Run `maid help`
# * Read the README, tutorial, and documentation at https://github.com/benjaminoakes/maid#maid
# * Ask me a question over email (hello@benjaminoakes.com) or Twitter (@benjaminoakes)
# * Check out how others are using Maid in [the Maid wiki](https://github.com/benjaminoakes/maid/wiki)

Maid.rules do
  # **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing
  # what they do, you might run into unwanted results!

  rule 'pdf handler' do
    move(dir('~/Downloads/*.pdf'), '~/Desktop/pdf')
  end

  rule 'deb handler' do
    move(dir('~/Downloads/*.deb'), '~/Desktop/deb')
  end

  rule 'pem handler' do
    move(dir('~/Downloads/*.pem'), '~/Desktop/pem')
  end

  rule 'sd-img handler' do
    move(dir('~/Downloads/*.sd-img'), '~/Desktop/sd-img')
  end

  rule 'script handler' do
    move move(dir('~/Download/*.sh'), '~/Desktop/scripts')
  end

  rule 'trash the rest' do
    trash(dir('~/Downloads/*'))
  end

end
