library(shiny)

ui <- fluidPage(
  fluidRow(
    column(width = 12,
           textInput("input1", "Input 1"),
           textInput("input2", "Input 2")
    )
  ),
  fluidRow(
    column(width = 12,
           plotOutput("output")
    )
  )
)

server <- function(input, output) {}

shinyApp(ui, server)

tekst <- "Først, det med pengemengdevekst blir i liten grad lært bort til studentene fordi de fleste læreboker ikke dekker dette. Men til tross for dette, har jeg selv dekket temaet de gangene jeg underviste i makroøkonomi (vil DM mine notater). Dersom inflasjonsmålet er på 2 prosent og det ikke skjer teknologisk framgang, bør også pengemengdeveksten være på 2 prosent (noe som gir eksponsiell vekst) dersom man kommuniserer at man skal oppfylle dette målet (i pengepolitikk bør .Generelt vil en økning i pengemengden omdirigere ressurstene i økonomien på en raskere måte. Det er mulig her å peke situasjoner hvor dette er nyttig:1. Raskere kunne starte opp nye bedrifter som tar i bruk nye og moderne teknologi 2. En økonomisk opphenting etter en stor nedgangskonjunktur vil gå raskere 3. Holde i livet sektorer som er konkurstruede, men hvor det anses som samfunnsnyttig nyttig at kunnskapen som bedriftene besitter ikke spres for vær og vind ved en konkurs. 4. Økte investeringer kommer på bekostning av konsum, og dermed på lang sikt gir økonomisk vekst. 1. Få for stor investering i ulønnsome prosjekter 2. Omfordelignseffekt 3. Holde i live ulønnsomme bedrifter I bunn og grunnn vil en effektiv pengepolitkk gå ut på å balansere alle disse hensynene. Er selv ingen styringsoptimist på dette området, og ønsker derfor i størst mulig grad en forutsigbar pengepolitkk. Mener vi har to gode eksempler som viser at det kan gå galt begge veier. - Strupingen av pengemengden etter bankkrisen 1929 som forlenget den store depresjonene. - Økningen i pengemengden under pandemien(?) i perioden. 2020-2022, som delvis forklarer den  høye inflasjonen som vi har i dag."



cat(chatgpt::ask_chatgpt(paste0("Fiks språk: ",tekst)))





