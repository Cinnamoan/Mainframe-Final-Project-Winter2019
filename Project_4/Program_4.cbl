       identification division.
       program-id. program_4.
       author. name Waqar Naseer.
       date-written. 2019-04-13.
      *Program Description: The purpose of this program is basically
      *to produce a report from the returns dat file aswell as produce
      *detail report.
       environment division.
      
       input-output section.
       file-control.
           select returns-file  
               assign to "../../../../Dummy/data/returns.dat"
               organization is line sequential.
                    
           select report-file 
               assign to "../../../../Dummy/data/returns.out"
               organization is line sequential.

       data division.
       file section.
       fd returns-file 
           data record is input-line
           record contains 36 characters.
      
       01 input-line.
           05 il-transaction-code           pic x.
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
           record contains 153 characters.
      
       01 report-line                       pic x(153).
      
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
           05 filler                        pic x(98)
               value spaces.
           05 filler                        pic x(35)
               value "MAFD4202 - Team Project: Program #4".
       
      *This header will display the report header and the page 
      *number.
       01 ws-heading2-title.
           05 filler                        pic x(26)
               value spaces.
           05 filler                        pic x(15)
               value "Returns Report ".
           05 filler                        pic x(14)
               value "         PAGE ".
           05 ws-page-counter               pic 9(1)
               value 0.
           05 filler                        pic x(97)
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
           05 filler                        pic x(43)
               value spaces.

               
      *This heading4 group identifies the total R records and 
      *the total transaction amount.                                     amounts.
       01 ws-heading4-records-totals-line-1.
           05 filler                        pic x(28)
               value "Total number of 'R' records:".
           05 filler                        pic x(1)
               value spaces.
           05 ws-returns-number             pic 99
               value 0.
           05 filler                        pic x(3)
               value spaces.
           05 filler                        pic x(17)
               value "Total Amount 'R':".
           05 filler                        pic x
               value spaces.
           05 ws-returns-amount             pic $$9.99
               value 0.
           05 filler                        pic x(95)
               value spaces.

      *This line will display the total number of each 'CA', 'CR'
      *and 'DB' records.
       01 ws-percentages-Payment-Types-totals-line-1.
           05 filler                        pic x(29)
               value "Total number of 'CA' records:".

           05 ws-payment-ca-amount          pic z9.
           05 filler                        pic x(6)
               value spaces.
           05 filler                        pic x(29)
               value "Total number of 'CR' records:".
           05 filler                        pic x
               value spaces.
           05 ws-payment-cr-amount          pic z9.
           05 filler                        pic x(7)
               value spaces.
           05 filler                        pic x(29)
               value "Total number of 'DB' records:".
           05 ws-payment-db-amount          pic z9.
           05 filler                        pic x(46)
               value spaces.

      *This line will display the total percentage of each 'CA', 'CR'
      *and 'DB' records.
       01 ws-percentages-Payment-Types-totals-line-2.
           05 filler                        pic x(27)
               value "Percentage of 'CA' records:".
           05 filler                        pic x(3)
               value spaces.
           05 ws-payment-ca-perc            pic z9.99.
           05 ws-perc-sgn                   pic x
               value "%".
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(27)
               value "Percentage of 'CR' records:".
           05 filler                        pic x(3)
               value spaces.
           05 ws-payment-cr-perc            pic z9.99.
           05 ws-perc-sgn                   pic x
               value "%".
           05 filler                        pic x(3)
               value spaces.
           05 filler                        pic x(27)
               value "Percentage of 'DB' records:".
           05 filler                        pic x(1)
               value spaces.
           05 ws-payment-db-perc            pic z9.99.
           05 ws-perc-sgn                   pic x
               value "%".
           05 filler                        pic x(42)
               value spaces.

      *This line will display the total tax owing (SHOULD BE
      *TOTAL TAXES OWED TO US).
       01 ws-totaltax-totals-line-4.
           05 filler                        pic x(16)
               value "Total Tax Owing:".
           05 filler                        pic x(3)
               value spaces.
           05 ws-total-tax-owing            pic $$$,$$9.99.
           05 filler                        pic x(93)
               value spaces.

      *This line shows the total transaction amount for each
      *store number.
       01 ws-totals-store-amount-line.
           05 filler                        pic x(14)
               value "Store 1 Total:".
           05 filler                        pic x
               value spaces.
           05 ws-store-1-total              pic $$9.99.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(14)
               value "Store 2 Total:".
           05 filler                        pic x
               value spaces.
           05 ws-store-2-total              pic $$9.99.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(14)
               value "Store 3 Total:".
           05 filler                        pic x
               value spaces.
           05 ws-store-3-total              pic $$9.99.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(14)
               value "Store 4 Total:".
           05 filler                        pic x
               value spaces.
           05 ws-store-4-total              pic $$9.99.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(14)
               value "Store 5 Total:".
           05 ws-store-5-total              pic zz9.99
               value 0.
           05 filler                        pic x(1)
               value spaces.
           05 filler                        pic x(15)
               value "Store 12 Total:".
           05 filler                        pic x
               value spaces.
           05 ws-store-12-total             pic $$9.99
               value 0.
           05 filler                        pic x(18)
               value spaces.

      *This line shows the total number of records which has
      *either of the six valid store numbers.
       01 ws-totals-store-record-line.
           05 filler                        pic x(21)
               value "Store #1 'R' Records:".
           05 filler                        pic x
               value spaces.
           05 ws-store-1-r-total            pic z9.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(21)
               value "Store #2 'R' Records:".
           05 filler                        pic x
               value spaces.
           05 ws-store-2-r-total            pic z9.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(21)
               value "Store #3 'R' Records:".
           05 filler                        pic x
               value spaces.
           05 ws-store-3-r-total            pic z9.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(21)
               value "Store #4 'R' Records:".
           05 filler                        pic x
               value spaces.
           05 ws-store-4-r-total            pic z9.
           05 filler                        pic x(2)
               value spaces.
           05 filler                        pic x(21)
               value "Store #5 'R' Records:".
           05 ws-store-5-r-total            pic z9.
           05 filler                        pic x(1)
               value spaces.
           05 filler                        pic x(22)
               value "Store #12 'R' Records:".
           05 filler                        pic x
               value spaces.
           05 ws-store-12-r-total           pic z9.

      *This line will be used to format and separate data.
       01 ws-report-detail-line.
           05 filler                        pic x(5)
               value spaces.
           05 ws-rpt-trans-code             pic x.
           05 filler                        pic x(9).
           05 ws-rpt-trans-amount           pic $$$,$$9.99.
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
           05 ws-rpt-tax-owing              pic $$$$9.99.
           05 filler                        pic x(47)
               value spaces.
       
       01 computing-variables.
           05 ws-tax-owing                  pic 9(5)v99
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
           05 ws-total-return-amount        pic 9(5)v99.
           05 ws-store-1-totals             pic 9(5)v99.
           05 ws-store-2-totals             pic 9(5)v99.
           05 ws-store-3-totals             pic 9(5)v99.
           05 ws-store-4-totals             pic 9(5)v99.
           05 ws-store-5-totals             pic 9(5)v99.
           05 ws-store-12-totals            pic 9(5)v99.
           05 ws-store-1-r-totals           pic 9(5)v99.
           05 ws-store-2-r-totals           pic 9(5)v99.
           05 ws-store-3-r-totals           pic 9(5)v99.
           05 ws-store-4-r-totals           pic 9(5)v99.
           05 ws-store-5-r-totals           pic 9(5)v99.
           05 ws-store-12-r-totals          pic 9(5)v99.

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
       
       procedure division.
       000-main.
           open input  returns-file,
           open output report-file.
      
           read returns-file 
               at end move 'y'         to ws-eof-flag.
      
           perform 100-process-pages
               varying ws-page-count from 1 by 1
               until   ws-eof-flag = 'y'.

           close   returns-file
                   report-file.
      
           stop run.
      
       100-process-pages.

               add 1 to ws-page-counter.

               perform 200-print-headings.
           
               perform 300-process-lines 
                   varying ws-line-count from 1 by 1
                   until ws-line-count > ws-lines-per-page 
                   or ws-eof-flag = 'y'.

      *    Print out all totals headers.

               write report-line from 
                   ws-totals-store-amount-line
                   after advancing 2 line.
               write report-line from
                   ws-heading4-records-totals-line-1
                   after advancing 1 line.
               write report-line from
                   ws-totals-store-record-line
                   after advancing 1 line.
               write report-line from 
               ws-percentages-Payment-Types-totals-line-1
                   after advancing 1 line.
               write report-line from 
               ws-percentages-Payment-Types-totals-line-2
                   after advancing 1 line.
               write report-line from ws-totaltax-totals-line-4
                   after advancing 1 line.
      
       200-print-headings.
       
           move spaces                 to ws-report-detail-line.
           
      *    Print identifier headers.

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
           move il-transaction-code         to ws-rpt-trans-code.
           move il-transaction-amount       to ws-rpt-trans-amount.
           move il-payment-type             to ws-rpt-payment-type.
           move il-store-number             to ws-rpt-store-number.
           move il-invoice-number           to ws-rpt-invoice-number.
           move il-sku-code                 to ws-rpt-sku-code.
           move ws-tax-owing                to ws-rpt-tax-owing.
           move ws-ca-counter               to ws-payment-ca-amount.
           move ws-cr-counter               to ws-payment-cr-amount.
           move ws-db-counter               to ws-payment-db-amount.
           move ws-ca-perc-count            to ws-payment-ca-perc.
           move ws-cr-perc-count            to ws-payment-cr-perc.
           move ws-db-perc-count            to ws-payment-db-perc.
           move ws-total-tax                to ws-total-tax-owing.
           move ws-total-return-amount      to ws-returns-amount.
           move ws-store-1-totals           to ws-store-1-total.
           move ws-store-2-totals           to ws-store-2-total.
           move ws-store-3-totals           to ws-store-3-total.
           move ws-store-4-totals           to ws-store-4-total.
           move ws-store-5-totals           to ws-store-5-total.
           move ws-store-12-totals          to ws-store-12-total.
           move ws-store-1-r-totals         to ws-store-1-r-total.
           move ws-store-2-r-totals         to ws-store-2-r-total.
           move ws-store-3-r-totals         to ws-store-3-r-total.
           move ws-store-4-r-totals         to ws-store-4-r-total.
           move ws-store-5-r-totals         to ws-store-5-r-total.
           move ws-store-12-r-totals        to ws-store-12-r-total.

           write report-line from ws-report-detail-line
               after advancing 2 line
      
           read returns-file 
               at end move 'y'         to ws-eof-flag.
      
       400-process-totals.

      *    Determine the record's payment type and add up
      *    the record's transaction amount to the respective payment
      *    type's overall transaction amount.
           if il-payment-ca-88
               add 1 to ws-ca-counter
               add 1 to ws-total-payment-records
           else
           if il-payment-cr-88
               add 1 to ws-cr-counter
               add 1 to ws-total-payment-records
           else
           if il-payment-db-88
               add 1 to ws-db-counter
               add 1 to ws-total-payment-records
           end-if
           end-if
           end-if.

      *    Increment record counter.
           add 1 to ws-returns-number.

      *    Add all transaction amounts.
           add il-transaction-amount to ws-total-return-amount.

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
                add il-transaction-amount to ws-store-1-totals
                add 1                     to ws-store-1-r-totals
           else
           if il-store-02-88
               add il-transaction-amount  to ws-store-2-totals
               add 1                      to ws-store-2-r-totals
           else
           if il-store-03-88
               add il-transaction-amount  to ws-store-3-totals
               add 1                      to ws-store-3-r-totals
           else
           if il-store-04-88 
               add il-transaction-amount  to ws-store-4-totals
               add 1                      to ws-store-4-r-totals
           else
           if il-store-05-88
               add il-transaction-amount  to ws-store-5-totals
               add 1                      to ws-store-5-r-totals
           else
           if il-store-12-88
               add il-transaction-amount  to ws-store-12-totals
               add 1                      to ws-store-12-r-totals
           end-if
           end-if
           end-if
           end-if
           end-if
           end-if.

       end program program_4.