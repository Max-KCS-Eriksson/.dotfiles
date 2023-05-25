# Functions defining segments must be prefixed with "prompt_", and will be called
# without said prefix in the list of prompt elements.
#
# Example:
#   prompt_prompt () {
#       p10k segment -b black -f white -i <do something>
#   }
#
#   typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
#     prompt        # Will show output from function
#   )


# Witty message to use before `prompt_char`
function prompt_message() {
    p10k segment -b black -f black -i $'%BYour command is my wish%b'
}
