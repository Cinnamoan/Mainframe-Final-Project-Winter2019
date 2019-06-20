       identification division.
       program-id. program_3.
       author. name Waqar Naseer.
       date-written. 2019-04-13.
      *Program Description: The purpose of this program is basically
      *to produce a report from the S&L dat file aswell as produce
      *detail report.
       environment division.
      
       input-output section.
       file-control.
           select sales-file  
               assign to "../../../../Dummy/data/s&l.dat"
               organization is line sequential.
                    
           select report-file 
               assign to "../../../../Dummy/data/s&l.out"
               organization is line sequential.

       data division.
       file section.
       fd sales-file 
           data record is input-line
           record contains 36 characters.
      
       01 input-line.
           05 il-transaction-code           pic x.
               88 il-sale-transac-88
                   value 'S'.
               88 il-layaway-transac-88
                   value 'L'.
           05 il-transaction-amount         pic 9(5)v99.
           05 il-payment-type               pic xx.
               88 il-payment-cr-88
                   value "CR".
               88 il-payment-ca-88
                   value "CA".
               88 il-payment-db-88
                   value "DB".
           05 il-store-number               pic 9(2).
               88 il-store-01-88
                   value 01.
               88 il-store-02-88
                   value 02.
               88 il-store-03-88
                   value 03.
               88 il-store-04-88
                   value 04.
               88 il-store-05-88
                   value 05.
               88 il-store-12-88
                   value 12.
           05 il-invoice-number             pic x(9).
           05 il-sku-code                   pic x(15).
      
       fd report-file 
           data record is report-line
           record contains 110 characters.
      
       01 report-line                       pic x(110).
      
       working-storage section.
      
       01 ws-eof-flag                       pic x 
           value 'n'.
      
      *This header will display the author(s) of this program and the
      *title for this team project.
       01 ws-heading1-name-line.
           05 filler                        pic x(7)
               value "Author:".
           05 filler                        pic x(1)
               value spaces.
           05 filler                        pic x(12)
               value "Waqar Naseer".
           05 filler                        pic x(55)
               value spaces.
           05 filler                        pic x(35)
               value "MAFD4202 - Team Project: Program #3".
       
      *This header will display the report header and the page 
      *number.
       01 ws-heading2-title.
           05 filler                        pic x(26)
               value spaces.
           05 filler                        pic x(24)
               value "Sales and Layaway Report ".
           05 filler                        pic x(14)
               value "         PAGE ".
           05 ws-page-counter               pic 9(1)
               value 0.
           05 filler                        pic x(45)
               value spaces.

      *This header is used to identify columns of data.
       01 ws-heading3-title.
           05 filler                        pic x(1)
               value spaces.
           05 filler                        pic x(10)
               value "Trans Code".
           05 filler                        pic x(4)
               value spaces.
           05 filler                        pic x(12)
               value "Trans Amount".
           05 filler                        pic x(4)
               value spaces.
           05 filler                        pic x(12)
               value "Payment Type".
           05 filler                        pic x(4)
               value spaces.
           05 filler                        pic x(12)
               value "Store Number".
           05 filler                        pic x(4)
               value spaces.
           05 filler                        pic x(14)
               value "Invoice Number".
           05 filler                        pic x(8)
               value spaces.
           05 filler                        pic x(8)
               value "SKU Code".
           05 filler                        pic x(8)
               value spaces.
           05 filler                        pic x(9)
               value "Tax Owing".
               
      *This heading4 group identifies all S, L, and
      *both S&L total records and transaction amounts.
       01 ws-heading4-sale-and-layaway-totals-line-1.
           05 filler                        pic x(28)
               value "Total number of S&L records:".
           05 filler                        pic x(1)
               value spaces.
           05 ws-sale-layaway-number        pic zz9.
           05 filler                        pic x(5)
               value spaces.
           05 filler                        pic x(17)
               value "S&L Total Amount:".
           05 filler                        pic x(11)
               value spaces.
           05 ws-sales-layaway-Total-amount pic $$$,$$9.99.
           05 filler                        pic x(35)
               value spaces.

      *This heading4 group identifies all S records and
      *transaction amounts.
       01 ws-heading4-sale-and-layaway-totals-line-2.
           05 filler                        pic x(28)
               value "Total number of 'S' records:".
           05 filler                        pic x(1)
               value spaces.
           05 ws-sales-total-Number         pic zz9.
           05 filler                        pic x(5)
               value spaces.
           05 filler                        pic x(25)
               value "'S' records total amount:".
           05 filler                        pic x(3)
               value spaces.
           05 ws-sales-total-amount         pic $$$,$$9.99.
           05 filler                        pic x(25)
               value spaces.

      *This heading4 group identifies all L records and
      *transaction amounts.
       01 ws-heading4-sale-and-layaway-totals-line-3.
           05 filler                        pic x(28)
               value "Total number of 'L' records:".
           05 filler                        pic x(2)
               value spaces.
           05 ws-Layaway-total-number       pic zz
               value 0.
           05 filler                        pic x(5)
               value spaces.
           05 filler                        pic x(28)
               value "'L' records total amount:".
           05 ws-Layaway-Total-amount       pic $$$,$$9.99.
           05 filler                        pic x(35)
               value spaces.

      *This line will display the total number of each 'CA', 'CR'
      *and 'DB' records.
       01 ws-percentages-Payment-Types-totals-line-4.
           05 filler                        pic x(29)
               value "Total number of 'CA' records:".
           05 ws-payment-ca-amount          pic z9.
           05 filler                        pic x(6)
               value spaces.
           05 filler                        pic x(29)
               value "Total number of 'CR' records:".
           05 ws-payment-cr-amount          pic z9.
           05 filler                        pic x(7)
               value spaces.
           05 filler                        pic x(29)
               value "Total number of 'DB' records:".
           05 ws-payment-db-amount          pic z9.

      *This line will display the total percentage of each 'CA', 'CR'
      *and 'DB' records.
       01 ws-percentages-Payment-Types-totals-line-5.
           05 filler                        pic x(27)
               value "Percentage of 'CA' records:".
           05 filler                        pic x(3)
               value spaces.
           05 ws-payment-ca-perc            pic z9.9.
           05 ws-perc-sgn                   pic x
               value "%".
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(27)
               value "Percentage of 'CR' records:".
           05 filler                        pic x(3)
               value spaces.
           05 ws-payment-cr-perc            pic z9.9.
           05 ws-perc-sgn                   pic x
               value "%".
           05 filler                        pic x(3)
               value spaces.
           05 filler                        pic x(27)
               value "Percentage of 'DB' records:".
           05 filler                        pic x(1)
               value spaces.
           05 ws-payment-db-perc            pic z9.9.
           05 ws-perc-sgn                   pic x
               value "%".
           05 filler                        pic x(2)
               value spaces.

      *This line will display the total tax owing.
       01 ws-totaltax-totals-line-5.
           05 filler                        pic x(16)
               value "Total Tax Owing:".
           05 filler                        pic x(3)
               value spaces.
           05 ws-total-tax-owing            pic $$$,$$9.99
               value 0.
           05 filler                        pic x(81)
               value spaces.

      *This header line will display the store number with
      *the highest total transaction amount.
       01 ws-store-sl-totals-line-6.
           05 filler                        pic x(53)
               value 
               "The Store # with highest S&Ltotal transaction amount:".
           05 filler                        pic x(8)
               value " Store#: ".
           05 ws-store-high-number          pic z9.
           05 filler                        pic x(9)
               value "   Value:".
           05 ws-store-sl-high-totals       pic $$$,$$9.99.
           05 filler                        pic x(28)
               value spaces.

      *This header line will display the store number with
      *the lowest total transaction amount.
       01 ws-store-sl-totals-line-7.
           05 filler                        pic x(52)
               value 
               "The Store # with lowest S&Ltotal transaction amount:".
           05 filler                        pic x(8)
               value " Store#: ".
           05 ws-store-low-number           pic z9.
           05 filler                        pic x(9)
               value "   Value:".
           05 ws-store-sl-low-totals        pic zz,zz9.99.
           05 filler                        pic x(29)
               value spaces.
      
      *This line will be used to format and separate data.
       01 ws-report-detail-line.
           05 filler                        pic x(4)
               value spaces.
           05 ws-rpt-Trans-Code             pic x.
           05 filler                        pic x(9).
           05 ws-rpt-Trans-Amount           pic $$$,$$9.99.
           05 filler                        pic x(12).
           05 ws-rpt-payment-type           pic x(2).
           05 filler                        pic x(13).
           05 ws-rpt-store-number           pic z9.
           05 filler                        pic x(11).
           05 ws-rpt-invoice-number         pic x(9).
           05 filler                        pic x(8).
           05 ws-rpt-sku-code               pic x(15).
           05 filler                        pic x(4)
               value spaces.
           05 ws-rpt-tax-owing              pic $$$,$$9.99.
       
       01 computing-variables.
           05 ws-tax-owing                  pic 9(5)v99
               value 0.
           05 ws-trans-amount-total-sale    pic 9(5)v99
               value 0.
           05 ws-trans-amnt-total-layway    pic 9(5)v99
               value 0.
           05 ws-trans-amnt-total-sal-lay   pic 9(5)v99
               value 0.
           05 ws-sales-counter              pic 99
               value 0.
           05 ws-sales-layaway-counter      pic 99
               value 0.
           05 ws-layaway-counter            pic 99
               value 0.
           05 ws-ca-counter                 pic 99
               value 0.
           05 ws-cr-counter                 pic 99
               value 0.
           05 ws-db-counter                 pic 99
               value 0.
           05 ws-ca-perc-count              pic 99v99
               value 0.
           05 ws-cr-perc-count              pic 99v99
               value 0.
           05 ws-db-perc-count              pic 99v99
               value 0.
           05 ws-total-tax                  pic 9(5)v99.
           05 ws-last-store-cnst            pic 9
               value 6.

       77 ws-line-count                     pic 99 
           value 0.
       77 ws-lines-per-page                 pic 99 
           value 20.
       77 ws-page-count                     pic 99 
           value 0.
       77 ws-tax-const                      pic 9v99
           value 0.13.
       77 ws-total-payment-records          pic 99
           value 0.
       77 ws-100-const                      pic 999
           value 100.
       01 ws-s-l-totals                     pic 9(5)v99
           value 0                          occurs 6 times.
       01 ws-sub                            pic 9
           value 1.
       01 ws-number-of-stores               pic 9
           value 6.
       01 ws-total-low-sl                   pic 9(8)
           value 99999999.
       01 ws-total-high-sl                  pic 9(5)v99
           value 0.
       01 ws-store-counter-high             pic 99
           value 0.
       01 ws-store-counter-low              pic 99
           value 0.
       01 ws-index-1                        pic 9
           value 1.
       01 ws-index-2                        pic 9
           value 2.
       01 ws-index-3                        pic 9
           value 3.
       01 ws-index-4                        pic 9
           value 4.
       01 ws-index-5                        pic 9
           value 5.
       01 ws-index-6                        pic 9
           value 6.

       procedure division.
       000-main.
           open input  sales-file,
           open output report-file.
      
           read sales-file 
               at end move 'y'         to ws-eof-flag.
      
           perform 100-process-pages
               varying ws-page-count from 1 by 1
               until   ws-eof-flag = 'y'.

           perform 500-print-totals.

           close   sales-file
                   report-file.
      
           stop run.
      
       100-process-pages.
               add 1 to ws-page-counter.
               perform 200-print-headings.
    
          
               perform 300-process-lines 
                   varying ws-line-count from 1 by 1
                   until ws-line-count > ws-lines-per-page 
                       or ws-eof-flag = 'y'.

       200-print-headings.
           
      *    Print all identifier headers.

           move spaces                 to ws-report-detail-line.
      
           if  ws-page-count = 1 then
               write report-line from ws-heading1-name-line             
           end-if.
      
           if  ws-page-count > 1 then
               move spaces             to report-line
               write report-line after page
               write report-line from ws-heading2-title
                   after advancing 1 line
               write report-line from ws-heading3-title
                   after advancing 2 line

           else
               write report-line from ws-heading2-title
                   after advancing 1 line
               write report-line from ws-heading3-title
                   after advancing 2 line

           end-if.

       300-process-lines.

           perform 400-process-totals.

           compute ws-tax-owing rounded = il-transaction-amount *
               ws-tax-const
           add ws-tax-owing                 to ws-total-tax.

      *    Move variables to their respective lines.
           move il-transaction-code         to ws-rpt-Trans-Code.
           move il-transaction-amount       to ws-rpt-Trans-Amount.
           move il-payment-type             to ws-rpt-payment-type.
           move il-store-number             to ws-rpt-store-number.
           move il-invoice-number           to ws-rpt-invoice-number.
           move il-sku-code                 to ws-rpt-sku-code.
           move ws-tax-owing                to ws-rpt-tax-owing.
           move ws-sales-counter            to ws-Sales-Total-Number.
           move ws-sales-layaway-counter    to ws-Sale-Layaway-number.
           move ws-layaway-counter          to ws-Layaway-total-number.
           move ws-trans-amnt-total-sal-lay 
               to ws-Sales-Layaway-Total-amount.
           move ws-trans-amnt-total-layway  to ws-Layaway-Total-amount.
           move ws-trans-amount-total-sale  to ws-Sales-Total-amount.
           move ws-ca-counter               to ws-payment-ca-amount.
           move ws-cr-counter               to ws-payment-cr-amount.
           move ws-db-counter               to ws-payment-db-amount.
           move ws-ca-perc-count            to ws-payment-ca-perc.
           move ws-cr-perc-count            to ws-payment-cr-perc.
           move ws-db-perc-count            to ws-payment-db-perc.
           move ws-total-tax                to ws-total-tax-owing.
           move ws-total-high-sl            to ws-store-sl-high-totals.
           move ws-store-counter-high       to ws-store-high-number.
           move ws-total-low-sl             to ws-store-sl-low-totals.
           move ws-store-counter-low        to ws-store-low-number
          
           write report-line from ws-report-detail-line
               after advancing 2 line
      
           read sales-file 
               at end move 'y'         to ws-eof-flag.
      
       400-process-totals.

      *    'S' records go here.
           if il-sale-transac-88
               add 1
                   to ws-sales-counter
               add 1
                   to ws-sales-layaway-counter
               add il-transaction-amount
                   to ws-trans-amount-total-sale
               add il-transaction-amount  
                   to ws-trans-amnt-total-sal-lay
           else
      *    'L' records go here.
           if il-layaway-transac-88
               add 1
                   to ws-layaway-counter
               add 1
                   to ws-sales-layaway-counter
               add il-transaction-amount 
                   to ws-trans-amnt-total-sal-lay
               add il-transaction-amount
                   to ws-trans-amnt-total-layway
           end-if
           end-if.

      *    Identify which payment type was used in the record.

           if il-payment-ca-88
               add 1
                   to ws-ca-counter
               add 1
                   to ws-total-payment-records
           else
           if il-payment-cr-88
               add 1
                   to ws-cr-counter
               add 1
                   to ws-total-payment-records
           else
           if il-payment-db-88
               add 1
                   to ws-db-counter
               add 1
                   to ws-total-payment-records
           end-if
           end-if
           end-if.

      *    Calculate the percentage of each payment types.

           compute ws-ca-perc-count = ws-ca-counter / 
               ws-total-payment-records * ws-100-const.

           compute ws-cr-perc-count = ws-cr-counter / 
               ws-total-payment-records * ws-100-const.

           compute ws-db-perc-count = ws-db-counter / 
               ws-total-payment-records * ws-100-const.

      *    Determine the record's store number and add the
      *    record's transaction to the store number's overall
      *    transaction amount.

            if il-store-01-88
               add il-transaction-amount
                   to ws-s-l-totals(ws-index-1)
           else
           if il-store-02-88
               add il-transaction-amount
                   to ws-s-l-totals(ws-index-2)
           else
           if il-store-03-88
               add il-transaction-amount
                   to ws-s-l-totals(ws-index-3)

           else
           if il-store-04-88
               add il-transaction-amount
                   to ws-s-l-totals(ws-index-4)
           else
           if il-store-05-88
               add il-transaction-amount
                   to ws-s-l-totals(ws-index-5)
           else
           if il-store-12-88
               add il-transaction-amount
                   to ws-s-l-totals(ws-index-6)
           end-if
           end-if
           end-if
           end-if
           end-if
           end-if.

      *    Loop through each store's number total transactions
           perform
               varying ws-sub
               from 1 by 1
               until ws-sub > ws-number-of-stores

      *        Determine the store number with the highest
      *        transaction amount.
               if(ws-total-high-sl < ws-s-l-totals(ws-sub))
                   move ws-s-l-totals(ws-sub)
                       to ws-total-high-sl
                   if ws-sub equals ws-last-store-cnst
                       move 12
                           to ws-store-counter-high
                   else
                       move ws-sub
                           to ws-store-counter-high
                   end-if
               end-if
      *        Determine the store number with the lowest
      *        transaction amount.
               if ws-total-low-sl > ws-s-l-totals(ws-sub)
                   move ws-s-l-totals(ws-sub)
                       to ws-total-low-sl
                   if ws-sub equals ws-last-store-cnst
                       move 12
                           to ws-store-counter-low
                   else
                       move ws-sub
                           to ws-store-counter-low
                   end-if
               end-if

           end-perform.

       500-print-totals.

           write report-line from 
               ws-heading4-sale-and-layaway-totals-line-1
               after advancing 2 line.
           write report-line from 
               ws-heading4-sale-and-layaway-totals-line-2
               after advancing 1 line.
           write report-line from 
               ws-heading4-sale-and-layaway-totals-line-3
               after advancing 1 line.
           write report-line from 
               ws-percentages-Payment-Types-totals-line-4
               after advancing 1 line.
           write report-line from
               ws-percentages-Payment-Types-totals-line-5
               after advancing 1 line.
           write report-line from
               ws-totaltax-totals-line-5
               after advancing 1 line.
           write report-line from ws-store-sl-totals-line-6
               after advancing 1 line.
           write report-line from ws-store-sl-totals-line-7
               after advancing 1 line.
                              
       end program program_3.