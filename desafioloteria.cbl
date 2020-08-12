      $set sourceformat"free"
      *>-----Divisão de identificação do programa
       identification division.
       program-id. "desafioloteria".
       author. "Elaine Martina Andre".
       installation. "PC".
       date-written. 12/08/2020.
       date-compiled. 12/08/2020.

      *>-----Divisão para configuração do ambiente
       environment division.
       configuration section.
           special-names. decimal-point is comma.

      *>-----Declaração dos recursos externos
       input-output section.
       file-control.
       i-o-control.

      *>-----Declaração de variáveis
       data division.

      *>-----Variaveis de arquivos
       file section.

      *>-----Variaveis de trabalho
       working-storage section.

      *>   Numeros sendo apostados
       77  ws-num1                                 pic 9(02).
       77  ws-num2                                 pic 9(02).
       77  ws-num3                                 pic 9(02).
       77  ws-num4                                 pic 9(02).
       77  ws-num5                                 pic 9(02).
       77  ws-num6                                 pic 9(02).
       77  ws-num7                                 pic 9(02).
       77  ws-num8                                 pic 9(02).
       77  ws-num9                                 pic 9(02).
       77  ws-num10                                pic 9(02).

      *>   Numeros sorteados
       77  ws-num-sort1                            pic 9(02).
       77  ws-num-sort2                            pic 9(02).
       77  ws-num-sort3                            pic 9(02).
       77  ws-num-sort4                            pic 9(02).
       77  ws-num-sort5                            pic 9(02).
       77  ws-num-sort6                            pic 9(02).

      *>   Quantidade de números sendo apostados
       77  ws-nr-apostas                           pic 9(02).

      *>   Sorteio
       77  ws-num-sort-aux                         pic 9(02)v999999.
       77  ws-semente                              pic 9(08).
       77  ws-semente1                             pic 9(08).

       77  ws-contador                             pic 9(8).

      *>   Tempo gasto até acertar a aposta
       77  ws-hora-inicio                          pic 9(08).
       77  ws-hora-final                           pic 9(08).
       77  ws-dif-hora                             pic 9(08).

       77  ws-menu                                 pic x(05).
           88 ws-fim                               value "true".
           88 ws-n-fim                             value "false".

       77  ws-cont                                 pic x(05).
           88 ws-repeticao                         value "true".
           88 ws-n-repeticao                       value "false".

      *>----Variaveis para comunicação entre programas
       linkage section.

      *>----Declaração de tela
       screen section.

      *>Declaração do corpo do programa
       procedure division.

           perform inicializa.
           perform processamento.
           perform finaliza.

      *>------------------------------------------------------------------------
      *>                     Procedimentos de Inicialização
      *>------------------------------------------------------------------------
       inicializa section.

      *>   Inicializando as variáveis para não conter sujeira
           move zero to ws-num1
           move zero to ws-num2
           move zero to ws-num3
           move zero to ws-num4
           move zero to ws-num5
           move zero to ws-num6
           move zero to ws-num7
           move zero to ws-num8
           move zero to ws-num9
           move zero to ws-num10

           move zero to ws-contador

           set ws-n-fim to true
           set ws-n-repeticao to true

           .
       inicializa-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                        Processamento Principal
      *>------------------------------------------------------------------------
       processamento section.
           display " --------------------------- Sorteio da Mega-Sena ----------------------------"
           display " "

      *>   Cartão de Aposta
           display "************************************************************"
           display "******************* Escolha Seus Numeros *******************"
           display "**                                                        **"
           display "**     01   02   03   04   05   06   07   08   09   10    **"
           display "**     11   12   13   14   15   16   17   18   19   20    **"
           display "**     21   22   23   24   25   26   27   28   29   30    **"
           display "**     31   32   33   34   35   36   37   38   39   40    **"
           display "**     41   42   43   44   45   46   47   48   49   50    **"
           display "**     51   52   53   54   55   56   57   58   59   60    **"
           display "**                                                        **"
           display "*********************** Boa Sorte!!! ***********************"
           display "************************************************************"
           display " "

      *>   Informaçoes dadas para o melhor funcionamento do jogo
           display " ----- Informacoes do Jogo ----- "
           display "1: Os Numeros Apostados Devem Estar no Intervalo de 1 a 60"
           display "2: Nao Repita Numeros Ja Apostados Para Ter Mais Chance de Ganhar"
           display "3: Cada Aposta Pode Conter De 6 a 10 Numeros"
           display " "
      *> ----------------------------------------------------
      *>   Informar a quantidade da aposta
           display "Digite '6'  Para Apostar 6  Numeros"
           display "Digite '7'  Para Apostar 7  Numeros"
           display "Digite '8'  Para Apostar 8  Numeros"
           display "Digite '9'  Para Apostar 9  Numeros"
           display "Digite '10' Para Apostar 10 Numeros"
           accept ws-nr-apostas
      *> ----------------------------------------------------
      *>   Chamar a section de acordo com a quantidade de números sendo apostados
           evaluate ws-nr-apostas
               when = 6
                   perform apostar-6-num
               when = 7
                   perform apostar-7-num
               when = 8
                   perform apostar-8-num
               when = 9
                   perform apostar-9-num
               when = 10
                   perform apostar-10-num
               when other
                   display "Opcao Invalida!"
           end-evaluate
      *> ----------------------------------------------------
           perform until ws-fim

      *>       Chamar section para sortear os 6 números
               perform sorteio

      *>       Aceitar a hora de inicio do sorteio
               accept ws-hora-inicio from time
      *>-------------------------------------------------------------------------
      *> Verificando se os números sorteados são diferentes um do outro e de zero
      *>-------------------------------------------------------------------------
               if  ws-num-sort1 <> ws-num-sort2
               and ws-num-sort1 <> ws-num-sort3
               and ws-num-sort1 <> ws-num-sort4
               and ws-num-sort1 <> ws-num-sort5
               and ws-num-sort1 <> ws-num-sort6
               and ws-num-sort1 <> 0 then

                   if  ws-num-sort2 <> ws-num-sort3
                   and ws-num-sort2 <> ws-num-sort4
                   and ws-num-sort2 <> ws-num-sort5
                   and ws-num-sort2 <> ws-num-sort6
                   and ws-num-sort2 <> 0 then

                       if  ws-num-sort3 <> ws-num-sort4
                       and ws-num-sort3 <> ws-num-sort5
                       and ws-num-sort3 <> ws-num-sort6
                       and ws-num-sort3 <> 0 then

                           if  ws-num-sort4 <> ws-num-sort5
                           and ws-num-sort4 <> ws-num-sort6
                           and ws-num-sort4 <> 0 then

                               if  ws-num-sort5 <> ws-num-sort6
                               and ws-num-sort5 <> 0 then

      *>                       Conta a quantidade de sorteios ja realizados
                               compute ws-contador = ws-contador + 1
                               set ws-repeticao to true

      *>                       Mostra os numeros sorteados na tela
                               display ws-num-sort1 " - " ws-num-sort2 " - " ws-num-sort3 " - " ws-num-sort4 " - " ws-num-sort5 " - " ws-num-sort6
                               display "Foram " ws-contador " Tentativas Ate o Momento"

                               end-if
                           end-if
                       end-if
                   end-if
               end-if
      *>-------------------------------------------------------------------------
      *> Verificando se os números apostados são iguais aos sorteados
      *>-------------------------------------------------------------------------
               if ws-repeticao then

                   if ws-num1  =  ws-num-sort1
                   or ws-num2  =  ws-num-sort1
                   or ws-num3  =  ws-num-sort1
                   or ws-num4  =  ws-num-sort1
                   or ws-num5  =  ws-num-sort1
                   or ws-num6  =  ws-num-sort1
                   or ws-num7  =  ws-num-sort1
                   or ws-num8  =  ws-num-sort1
                   or ws-num9  =  ws-num-sort1
                   or ws-num10 =  ws-num-sort1 then

                       if ws-num1  =  ws-num-sort2
                       or ws-num2  =  ws-num-sort2
                       or ws-num3  =  ws-num-sort2
                       or ws-num4  =  ws-num-sort2
                       or ws-num5  =  ws-num-sort2
                       or ws-num6  =  ws-num-sort2
                       or ws-num7  =  ws-num-sort2
                       or ws-num8  =  ws-num-sort2
                       or ws-num9  =  ws-num-sort2
                       or ws-num10 =  ws-num-sort2 then

                           if ws-num1  =  ws-num-sort3
                           or ws-num2  =  ws-num-sort3
                           or ws-num3  =  ws-num-sort3
                           or ws-num4  =  ws-num-sort3
                           or ws-num5  =  ws-num-sort3
                           or ws-num6  =  ws-num-sort3
                           or ws-num7  =  ws-num-sort3
                           or ws-num8  =  ws-num-sort3
                           or ws-num9  =  ws-num-sort3
                           or ws-num10 =  ws-num-sort3 then

                               if ws-num1  =  ws-num-sort4
                               or ws-num2  =  ws-num-sort4
                               or ws-num3  =  ws-num-sort4
                               or ws-num4  =  ws-num-sort4
                               or ws-num5  =  ws-num-sort4
                               or ws-num6  =  ws-num-sort4
                               or ws-num7  =  ws-num-sort4
                               or ws-num8  =  ws-num-sort4
                               or ws-num9  =  ws-num-sort4
                               or ws-num10 =  ws-num-sort4 then

                                   if ws-num1  =  ws-num-sort5
                                   or ws-num2  =  ws-num-sort5
                                   or ws-num3  =  ws-num-sort5
                                   or ws-num4  =  ws-num-sort5
                                   or ws-num5  =  ws-num-sort5
                                   or ws-num6  =  ws-num-sort5
                                   or ws-num7  =  ws-num-sort5
                                   or ws-num8  =  ws-num-sort5
                                   or ws-num9  =  ws-num-sort5
                                   or ws-num10 =  ws-num-sort5 then

                                       if ws-num1  =  ws-num-sort6
                                       or ws-num2  =  ws-num-sort6
                                       or ws-num3  =  ws-num-sort6
                                       or ws-num4  =  ws-num-sort6
                                       or ws-num5  =  ws-num-sort6
                                       or ws-num6  =  ws-num-sort6
                                       or ws-num7  =  ws-num-sort6
                                       or ws-num8  =  ws-num-sort6
                                       or ws-num9  =  ws-num-sort6
                                       or ws-num10 =  ws-num-sort6 then

                                       set ws-fim to true

                                       end-if
                                   end-if
                               end-if
                           end-if
                       end-if
                   end-if

               end-if

               set ws-n-repeticao to true

           end-perform
      *>------------------------------------------------------------------------
      *> Se acertar todos os 6 números sorteados - Ganhou na Mega-Sena!
      *>------------------------------------------------------------------------
           if ws-fim then
               display "***************************************"
               display "*PARABENS, VOCE GANHOU NA MEGA-SENA!!!*"
               display "***************************************"

      *>       Aceitar a hora que o sorteio finaliza
               accept ws-hora-final from time
      *>       Calcular qual foi o tempo gasto até acertar a aposta
               compute ws-dif-hora = ws-hora-final - ws-hora-inicio
           end-if

           display "Foram " ws-contador " Tentativas Ate Acertar os Numeros Secretos"
           display "O Tempo Gasto Ate Acertar os Numeros Secretos Foi de " ws-dif-hora
           .
       processamento-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                         Apostar 6 Números
      *>------------------------------------------------------------------------
       apostar-6-num section.

           display "Tente a Sorte e Advinhe os 6 Numeros Secretos: "
           display " "
      *> -------------------------------------------- 1º
           display "Primeiro Numero a Ser Apostado: "
           accept  ws-num1
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60
           if ws-num1 < 1 or > 60 then
               display "Numero Invalido, Informe um Numero Dentro do Intervalo de 1 a 60"
               accept  ws-num1
           end-if
      *> -------------------------------------------- 2º
           display "Segundo Numero a Ser Apostado : "
           accept  ws-num2
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60 e não está sendo repetido
           if ws-num2 < 1 or > 60
                          or = ws-num1 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num2
           end-if
      *> -------------------------------------------- 3º
           display "Terceiro Numero a Ser Apostado: "
           accept  ws-num3
           if ws-num3 < 1 or > 60
                          or = ws-num1
                          or = ws-num2 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num3
           end-if
      *> -------------------------------------------- 4º
           display "Quarto Numero a Ser Apostado  : "
           accept  ws-num4
           if ws-num4 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num4
           end-if
      *> -------------------------------------------- 5º
           display "Quinto Numero a Ser Apostado  : "
           accept  ws-num5
           if ws-num5 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num5
           end-if
      *> -------------------------------------------- 6º
           display "Sexto Numero a Ser Apostado   : "
           accept  ws-num6
           if ws-num6 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num6
           end-if

           .
       apostar-6-num-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                         Apostar 7 Números
      *>------------------------------------------------------------------------
       apostar-7-num section.

           display "Tente a Sorte e Advinhe os 7 Numeros Secretos: "
           display " "
      *> -------------------------------------------- 1º
           display "Primeiro Numero a Ser Apostado: "
           accept  ws-num1
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60
           if ws-num1 < 1 or > 60 then
               display "Numero Invalido, Informe um Numero Dentro do Intervalo de 1 a 60"
               accept  ws-num1
           end-if
      *> -------------------------------------------- 2º
           display "Segundo Numero a Ser Apostado : "
           accept  ws-num2
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60 e não está sendo repetido
           if ws-num2 < 1 or > 60
                          or = ws-num1 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num2
           end-if
      *> -------------------------------------------- 3º
           display "Terceiro Numero a Ser Apostado: "
           accept  ws-num3
           if ws-num3 < 1 or > 60
                          or = ws-num1
                          or = ws-num2 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num3
           end-if
      *> -------------------------------------------- 4º
           display "Quarto Numero a Ser Apostado  : "
           accept  ws-num4
           if ws-num4 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num4
           end-if
      *> -------------------------------------------- 5º
           display "Quinto Numero a Ser Apostado  : "
           accept  ws-num5
           if ws-num5 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num5
           end-if
      *> -------------------------------------------- 6º
           display "Sexto Numero a Ser Apostado   : "
           accept  ws-num6
           if ws-num6 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num6
           end-if
      *> -------------------------------------------- 7º
           display "Setimo Numero a Ser Apostado  : "
           accept  ws-num7
           if ws-num7 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num7
           end-if

           .
       apostar-7-num-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                         Apostar 8 Números
      *>------------------------------------------------------------------------
       apostar-8-num section.

           display "Tente a Sorte e Advinhe os 8 Numeros Secretos: "
           display " "
      *> -------------------------------------------- 1º
           display "Primeiro Numero a Ser Apostado: "
           accept  ws-num1
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60
           if ws-num1 < 1 or > 60 then
               display "Numero Invalido, Informe um Numero Dentro do Intervalo de 1 a 60"
               accept  ws-num1
           end-if
      *> -------------------------------------------- 2º
           display "Segundo Numero a Ser Apostado : "
           accept  ws-num2
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60 e não está sendo repetido
           if ws-num2 < 1 or > 60
                          or = ws-num1 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num2
           end-if
      *> -------------------------------------------- 3º
           display "Terceiro Numero a Ser Apostado: "
           accept  ws-num3
           if ws-num3 < 1 or > 60
                          or = ws-num1
                          or = ws-num2 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num3
           end-if
      *> -------------------------------------------- 4º
           display "Quarto Numero a Ser Apostado  : "
           accept  ws-num4
           if ws-num4 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num4
           end-if
      *> -------------------------------------------- 5º
           display "Quinto Numero a Ser Apostado  : "
           accept  ws-num5
           if ws-num5 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num5
           end-if
      *> -------------------------------------------- 6º
           display "Sexto Numero a Ser Apostado   : "
           accept  ws-num6
           if ws-num6 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num6
           end-if
      *> -------------------------------------------- 7º
           display "Setimo Numero a Ser Apostado  : "
           accept  ws-num7
           if ws-num7 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num7
           end-if
      *> -------------------------------------------- 8º
           display "Oitavo Numero a Ser Apostado  : "
           accept  ws-num8
           if ws-num8 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6
                          or = ws-num7 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num8
           end-if

           .
       apostar-8-num-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                         Apostar 9 Números
      *>------------------------------------------------------------------------
       apostar-9-num section.

           display "Tente a Sorte e Advinhe os 9 Numeros Secretos: "
           display " "
      *> -------------------------------------------- 1º
           display "Primeiro Numero a Ser Apostado: "
           accept  ws-num1
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60
           if ws-num1 < 1 or > 60 then
               display "Numero Invalido, Informe um Numero Dentro do Intervalo de 1 a 60"
               accept  ws-num1
           end-if
      *> -------------------------------------------- 2º
           display "Segundo Numero a Ser Apostado : "
           accept  ws-num2
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60 e não está sendo repetido
           if ws-num2 < 1 or > 60
                          or = ws-num1 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num2
           end-if
      *> -------------------------------------------- 3º
           display "Terceiro Numero a Ser Apostado: "
           accept  ws-num3
           if ws-num3 < 1 or > 60
                          or = ws-num1
                          or = ws-num2 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num3
           end-if
      *> -------------------------------------------- 4º
           display "Quarto Numero a Ser Apostado  : "
           accept  ws-num4
           if ws-num4 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num4
           end-if
      *> -------------------------------------------- 5º
           display "Quinto Numero a Ser Apostado  : "
           accept  ws-num5
           if ws-num5 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num5
           end-if
      *> -------------------------------------------- 6º
           display "Sexto Numero a Ser Apostado   : "
           accept  ws-num6
           if ws-num6 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num6
           end-if
      *> -------------------------------------------- 7º
           display "Setimo Numero a Ser Apostado  : "
           accept  ws-num7
           if ws-num7 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num7
           end-if
      *> -------------------------------------------- 8º
           display "Oitavo Numero a Ser Apostado  : "
           accept  ws-num8
           if ws-num8 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6
                          or = ws-num7 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num8
           end-if
      *> -------------------------------------------- 9º
           display "Nono Numero a Ser Apostado    : "
           accept  ws-num9
           if ws-num9 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6
                          or = ws-num7
                          or = ws-num8 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num9
           end-if

           .
       apostar-9-num-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                         Apostar 10 Números
      *>------------------------------------------------------------------------
       apostar-10-num section.

           display "Tente a Sorte e Advinhe os 10 Numeros Secretos: "
           display " "
      *> -------------------------------------------- 1º
           display "Primeiro Numero a Ser Apostado: "
           accept  ws-num1
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60
           if ws-num1 < 1 or > 60 then
               display "Numero Invalido, Informe um Numero Dentro do Intervalo de 1 a 60"
               accept  ws-num1
           end-if
      *> -------------------------------------------- 2º
           display "Segundo Numero a Ser Apostado : "
           accept  ws-num2
      *>   Conferindo se o número sendo apostado está dentro do intervalo de 1 a 60 e não está sendo repetido
           if ws-num2 < 1 or > 60
                          or = ws-num1 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num2
           end-if
      *> -------------------------------------------- 3º
           display "Terceiro Numero a Ser Apostado: "
           accept  ws-num3
           if ws-num3 < 1 or > 60
                          or = ws-num1
                          or = ws-num2 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num3
           end-if
      *> -------------------------------------------- 4º
           display "Quarto Numero a Ser Apostado  : "
           accept  ws-num4
           if ws-num4 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num4
           end-if
      *> -------------------------------------------- 5º
           display "Quinto Numero a Ser Apostado  : "
           accept  ws-num5
           if ws-num5 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num5
           end-if
      *> -------------------------------------------- 6º
           display "Sexto Numero a Ser Apostado   : "
           accept  ws-num6
           if ws-num6 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num6
           end-if
      *> -------------------------------------------- 7º
           display "Setimo Numero a Ser Apostado  : "
           accept  ws-num7
           if ws-num7 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num7
           end-if
      *> -------------------------------------------- 8º
           display "Oitavo Numero a Ser Apostado  : "
           accept  ws-num8
           if ws-num8 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6
                          or = ws-num7 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num8
           end-if
      *> -------------------------------------------- 9º
           display "Nono Numero a Ser Apostado    : "
           accept  ws-num9
           if ws-num9 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6
                          or = ws-num7
                          or = ws-num8 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num9
           end-if
      *> -------------------------------------------- 10º
           display "Decimo Numero a Ser Apostado: "
           accept  ws-num10
           if ws-num10 < 1 or > 60
                          or = ws-num1
                          or = ws-num2
                          or = ws-num3
                          or = ws-num4
                          or = ws-num5
                          or = ws-num6
                          or = ws-num7
                          or = ws-num8
                          or = ws-num9 then
               display "O Numero Apostado Esta Fora do Intervalo de 1 a 60 ou Esta Sendo Repetido"
               accept  ws-num10
           end-if

           .
       apostar-10-num-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                         Sorteio dos Números
      *>------------------------------------------------------------------------
       sorteio section.

           perform semente-delay
      *>    accept ws-semente from time
           compute  ws-num-sort-aux =  function random(ws-semente) *> Gerando número randomico
           multiply ws-num-sort-aux by 60 giving ws-num-sort1      *> Multiplicando o número randomico por 60 para dar o número sorteado

      *>    accept ws-semente from time
           perform semente-delay
           compute  ws-num-sort-aux =  function random(ws-semente)
           multiply ws-num-sort-aux by 60 giving ws-num-sort2

      *>    accept ws-semente from time
           perform semente-delay
           compute  ws-num-sort-aux =  function random(ws-semente)
           multiply ws-num-sort-aux by 60 giving ws-num-sort3

      *>    accept ws-semente from time
           perform semente-delay
           compute  ws-num-sort-aux =  function random(ws-semente)
           multiply ws-num-sort-aux by 60 giving  ws-num-sort4

      *>    accept ws-semente from time
           perform semente-delay
           compute  ws-num-sort-aux =  function random(ws-semente)
           multiply ws-num-sort-aux by 60 giving ws-num-sort5

      *>    accept ws-semente from time
           perform semente-delay
           compute  ws-num-sort-aux =  function random(ws-semente)
           multiply ws-num-sort-aux by 60 giving  ws-num-sort6

      *>    go to finaliza

           .
       sorteio-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                         Semente Com Delay
      *>------------------------------------------------------------------------
       semente-delay section.  *> Delay de 1 centésimo de segundo

           perform 10 times
           accept ws-semente1 from time
               move  ws-semente1  to ws-semente
               perform until ws-semente > ws-semente1
                   accept ws-semente from time
               end-perform
           end-perform

           .
       semente-delay-exit.
           exit.
      *>------------------------------------------------------------------------
      *>                      Finalização Programa
      *>------------------------------------------------------------------------
       finaliza section.
           stop run
           .
       finaliza-exit.
           exit.

