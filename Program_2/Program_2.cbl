       identification division.
       program-id. Program_2.
       author. Ian Carlos.
       date-written. 2019-04-06.
      *Program Description: The purpose of this program is basically
      *to produce a report with some records counts and to split the
      *records onto 2 data files.

       environment division.
       configuration section.
       input-output section.

       file-control.

           select valid-file
           assign to "../../../../Dummy/data/valid.dat"
           organization is line sequential.

           select sale-and-layaway-file
           assign to "../../../../Dummy/data/s&l.dat"
           organization is line sequential.

           select return-file
           assign to "../../../../Dummy/data/returns.dat"
           organization is line sequential.

           select counts-and-control-total-report
           assign to "../../../../Dummy/data/counts-and-control.out"
           organization is line sequential.

       data division.
       file section.

       fd valid-file
           data record is valid-line
           record contains 36 characters.

       01 input-line.
           05 il-transaction-code           pic x.
               88 il-sale-and-layaway-transac-88
                   value 'S', 'L'.
               88 il-sale-transac-88
                   value 'S'.
               88 il-layaway-transac-88
                   value 'L'.
               88 il-return-transac-88
                   value 'R'.
           05 il-transaction-amount         pic 9(5)v99.
           05 il-payment-type               pic xx.
               88 il-payment-cash-88
                   value 'CA'.
               88 il-payment-credit-88
                   value 'CR'.
               88 il-payment-debit-88
                   value 'DB'.
           05 il-store-number               pic xx.
               88 il-store-01-88
                   value '01'.
               88 il-store-02-88
                   value '02'.
               88 il-store-03-88
                   value '03'.
               88 il-store-04-88
                   value '04'.
               88 il-store-05-88
                   value '05'.
               88 il-store-12-88
                   value '12'.
           05 il-invoice-number             pic x(9).
           05 il-sku-code                   pic x(15).

       fd sale-and-layaway-file
           data record is sale-and-layaway-line
           record contains 36 characters.

       01 sale-and-layaway-line             pic x(36).

       fd return-file
           data record is return-line
           record contains 36 characters.

       01 return-line                       pic x(36).

       fd counts-and-control-total-report
           data record is counts-and-control-total-line
           record contains 102 characters.

       01 counts-and-control-total-line     pic x(102).

       working-storage section.

      *Used to determine eof (end-of-file).
       01 ws-eof-flag                       pic x
           value 'N'.

      *Used for eof flag.
       01 ws-boolean-const.
           05 ws-true-const                 pic x
               value "Y".
           05 ws-false-const                pic x
               value "N".

      *This header will display the author(s) of this program and the
      *title for this team project.
       01 ws-heading1-name-line.
           05 filler                        pic x(7)
               value "Author:".
           05 filler                        pic x(1)
               value spaces.
           05 filler                        pic x(10)
               value "Ian Carlos".
           05 filler                        pic x(49)
               value spaces.
           05 filler                        pic x(35)
               value "MAFD4202 - Team Project: Program #2".

      *The title of the report for the controls and totals report.
       01 ws-heading2-counts-and-control-totals-header-line.
           05 filler                        pic x(36)
               value spaces.
           05 filler                        pic x(32)
               value "COUNTS AND CONTROL TOTALS REPORT".
           05 filler                        pic x(34)
               value spaces.

      *Header line to identify all associated totals
      *for S&L records.
       01 ws-heading3-s-and-l-header-line.
           05 filler                        pic x(25)
               value "SALES and LAYAWAY Records".
           05 filler                        pic x(77)
               value spaces.

      *This heading4 group identifies all S, L, and
      *both S&L total records and transaction amounts.
       01 ws-heading4-s-and-l-totals-line-1.
           05 filler                        pic x(28)
               value "Total number of S&L records:".
           05 filler                        pic x.
           05 ws-num-of-s-and-l-records     pic z9.
           05 filler                        pic x(35)
               value spaces.
           05 filler                        pic x(17)
               value "S&L Total Amount:".
           05 filler                        pic x(9)
               value spaces.
           05 ws-total-s-and-l-amount       pic $$$,$$9.99.

       01 ws-heading4-s-and-l-totals-line-2.
           05 filler                        pic x(28)
               value "Total number of 'S' records:".
           05 filler                        pic x(1).
           05 ws-num-of-s-records           pic z9.
           05 filler                        pic x(35)
               value spaces.
           05 filler                        pic x(25)
               value "'S' records total amount:".
           05 filler                        pic x
               value spaces.
           05 ws-total-s-amount             pic $$$,$$9.99.

       01 ws-heading4-s-and-l-totals-line-3.
           05 filler                        pic x(28)
               value "Total number of 'L' records:".
           05 filler                        pic x(1).
           05 ws-num-of-l-records           pic z9.
           05 filler                        pic x(35)
               value spaces.
           05 filler                        pic x(25)
               value "'L' records total amount:".
           05 filler                        pic x
               value spaces.
           05 ws-total-l-amount             pic $$$,$$9.99.

      *This heading5 group will store and display the total
      *transaction for each valid stores which are either or 
      *both S or L records.
       01 ws-heading5-s-and-l-stores-totals-line-1.
           05 filler                        pic x(41)
               value "Total transaction amount for '01' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-s-and-l-01-store     pic $$$,$$9.99. 
           05 filler                        pic x(50)
               value spaces.
       
       01 ws-heading5-s-and-l-stores-totals-line-2.
           05 filler                        pic x(41)
               value "Total transaction amount for '02' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-s-and-l-02-store     pic $$$,$$9.99. 
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading5-s-and-l-stores-totals-line-3.
           05 filler                        pic x(41)
               value "Total transaction amount for '03' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-s-and-l-03-store     pic $$$,$$9.99. 
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading5-s-and-l-stores-totals-line-4.
           05 filler                        pic x(41)
               value "Total transaction amount for '04' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-s-and-l-04-store     pic $$$,$$9.99. 
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading5-s-and-l-stores-totals-line-5.
           05 filler                        pic x(41)
               value "Total transaction amount for '05' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-s-and-l-05-store     pic $$$,$$9.99. 
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading5-s-and-l-stores-totals-line-6.
           05 filler                        pic x(41)
               value "Total transaction amount for '12' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-s-and-l-12-store     pic $$$,$$9.99. 
           05 filler                        pic x(50)
               value spaces.

      *This heading6 group shows the percentage of transactions for
      *each payment type that belong as an S, L or both S&L records.
       01 ws-heading6-s-and-l-payment-types-totals-line-1.
           05 filler                        pic x(28)
               value "% of transactions with Cash:".
           05 filler                        pic x(8)
               value spaces.
           05 ws-total-perc-cash            pic z9.99. 
           05 filler                        pic x
               value "%".
           05 filler                        pic x(55)
               value spaces.

       01 ws-heading6-s-and-l-payment-types-totals-line-2.
           05 filler                        pic x(35)
               value "% of transactions with Credit Card:".
           05 filler                        pic x 
               value spaces.
           05 ws-total-perc-credit          pic z9.99. 
           05 filler                        pic x
               value "%".
           05 filler                        pic x(60)
               value spaces.

       01 ws-heading6-s-and-l-payment-types-totals-line-3.
           05 filler                        pic x(34)
               value "% of transactions with Debit Card:".
           05 filler                        pic x(2)
               value spaces.
           05 ws-total-perc-debit           pic z9.99. 
           05 filler                        pic x
               value "%".
           05 filler                        pic x(60)
               value spaces.

      *Header line to identify all associated totals
      *for 'R' records.
       01 ws-heading7-r-header-line.
           05 filler                        pic x(14)
               value "RETURN Records".
           05 filler                        pic x(88)
               value spaces.

      *Header taht identifies all 'R' total records 
      *and transaction amounts.
       01 ws-heading8-r-totals-line.
           05 filler                        pic x(28)
               value "Total number of 'R' records:".
           05 filler                        pic x(1).
           05 ws-num-of-r-records           pic z9.
           05 filler                        pic x(35)
               value spaces.
           05 filler                        pic x(25)
               value "'R' records total amount:".
           05 filler                        pic x
               value spaces.
           05 ws-total-r-amount             pic $$$,$$9.99.

      *This heading9 group will store and display the total
      *transaction for each valid stores which are 'R' records.
       01 ws-heading9-r-stores-totals-line-1.
           05 filler                        pic x(41)
               value "Total transaction amount for '01' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-r-01-store           pic $$$,$$9.99. 
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading9-r-stores-totals-line-2.
           05 filler                        pic x(41)
               value "Total transaction amount for '02' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-r-02-store           pic $$$,$$9.99.
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading9-r-stores-totals-line-3.
           05 filler                        pic x(41)
               value "Total transaction amount for '03' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-r-03-store           pic $$$,$$9.99.
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading9-r-stores-totals-line-4.
           05 filler                        pic x(41)
               value "Total transaction amount for '04' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-r-04-store           pic $$$,$$9.99.
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading9-r-stores-totals-line-5.
           05 filler                        pic x(41)
               value "Total transaction amount for '05' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-r-05-store           pic $$$,$$9.99.
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading9-r-stores-totals-line-6.
           05 filler                        pic x(41)
               value "Total transaction amount for '12' stores:".
           05 filler                        pic x
               value spaces.
           05 ws-total-r-12-store           pic $$$,$$9.99.
           05 filler                        pic x(50)
               value spaces.

       01 ws-heading10-grand-total-line.
           05 filler                        pic x(19)
               value "Grand Total Amount:".
           05 filler                        pic x
               value spaces.
           05 ws-total-grand                pic $$$,$$9.99
               value spaces.
           05 filler                        pic x(72)
               value spaces.

      *Used to keep track of each transaction code record type.
       01 ws-counters.
           05 ws-sale-count                 pic 99
               value 0.
           05 ws-layaway-count              pic 99
               value 0.
           05 ws-sale-and-layway-count      pic 99
               value 0.
           05 ws-return-count               pic 99
               value 0.
           05 ws-cash-count                 pic 99
               value 0.
           05 ws-credit-count               pic 99
               value 0.
           05 ws-debit-count                pic 99
               value 0.

       01 ws-calulcations.
      *    Might need to change all of the pic clauses here.
           05 ws-sale-total-amount          pic 9(7)v99
               value 0.
           05 ws-layaway-total-amount       pic 9(7)v99
               value 0.
           05 ws-s-and-l-total-amount       pic 9(7)v99
               value 0.
           05 ws-return-total-amount        pic 9(7)v99
               value 0.
           05 ws-s-and-l-store-01-total     pic 9(7)v99
               value 0.
           05 ws-s-and-l-store-02-total     pic 9(7)v99
               value 0.
           05 ws-s-and-l-store-03-total     pic 9(7)v99
               value 0.
           05 ws-s-and-l-store-04-total     pic 9(7)v99
               value 0.
           05 ws-s-and-l-store-05-total     pic 9(7)v99
               value 0.
           05 ws-s-and-l-store-12-total     pic 9(7)v99
               value 0.
           05 ws-r-store-01-total           pic 9(7)v99
               value 0.
           05 ws-r-store-02-total           pic 9(7)v99
               value 0.
           05 ws-r-store-03-total           pic 9(7)v99
               value 0.
           05 ws-r-store-04-total           pic 9(7)v99
               value 0.
           05 ws-r-store-05-total           pic 9(7)v99
               value 0.
           05 ws-r-store-12-total           pic 9(7)v99
               value 0.
           05 ws-pay-cash-total             pic 9(7)v99
               value 0.
           05 ws-pay-credit-total           pic 9(7)v99
               value 0.
           05 ws-pay-debit-total            pic 9(7)v99
               value 0.
           05 ws-cash-percent               pic 99v99
               value 0.
           05 ws-credit-percent             pic 99v99
               value 0.
           05 ws-debit-percent              pic 99v99
               value 0.
           05 ws-overall-amount             pic 9(7)v99
               value 0.
           05 ws-grand-total-calc           pic 9(7)v99
               value 0.

       procedure division.
       000-main.

           move ws-false-const              to ws-eof-flag.

           open input valid-file,
                output sale-and-layaway-file,
                       return-file,
                       counts-and-control-total-report.

           read valid-file
               at end move ws-true-const    to ws-eof-flag.

           perform 200-determine-record
               until ws-eof-flag = ws-true-const.

           perform 100-print-headers.

           close valid-file,
                 sale-and-layaway-file,
                 return-file,
                 counts-and-control-total-report.

           display ws-cash-count.
           display ws-credit-count.
           display ws-debit-count.
           display ws-sale-and-layway-count.

           accept return-code.

           stop run.

       100-print-headers.

           write counts-and-control-total-line
               from ws-heading1-name-line.


           write counts-and-control-total-line  
               from ws-heading2-counts-and-control-totals-header-line
               after advancing 1 line.

      *    Sale and layaway records summary section.
           write counts-and-control-total-line  
               from ws-heading3-s-and-l-header-line
               after advancing 2 line.
           write counts-and-control-total-line  
               from ws-heading4-s-and-l-totals-line-1.
           write counts-and-control-total-line
               from ws-heading4-s-and-l-totals-line-2.
           write counts-and-control-total-line
               from ws-heading4-s-and-l-totals-line-3.
           write counts-and-control-total-line 
               from ws-heading5-s-and-l-stores-totals-line-1.
           write counts-and-control-total-line
               from ws-heading5-s-and-l-stores-totals-line-2.
           write counts-and-control-total-line
               from ws-heading5-s-and-l-stores-totals-line-3.
           write counts-and-control-total-line
               from ws-heading5-s-and-l-stores-totals-line-4.
           write counts-and-control-total-line
               from ws-heading5-s-and-l-stores-totals-line-5.
           write counts-and-control-total-line
               from ws-heading5-s-and-l-stores-totals-line-6.
           write counts-and-control-total-line
               from ws-heading6-s-and-l-payment-types-totals-line-1.
           write counts-and-control-total-line
               from ws-heading6-s-and-l-payment-types-totals-line-2.
           write counts-and-control-total-line
               from ws-heading6-s-and-l-payment-types-totals-line-3.

      *    Return records summary section.
           write counts-and-control-total-line 
               from ws-heading7-r-header-line
               after advancing 1 line.
           write counts-and-control-total-line
               from ws-heading8-r-totals-line.
           write counts-and-control-total-line
               from ws-heading9-r-stores-totals-line-1.
           write counts-and-control-total-line
               from ws-heading9-r-stores-totals-line-2.
           write counts-and-control-total-line
               from ws-heading9-r-stores-totals-line-3.
           write counts-and-control-total-line
               from ws-heading9-r-stores-totals-line-4.
           write counts-and-control-total-line
               from ws-heading9-r-stores-totals-line-5.
           write counts-and-control-total-line
               from ws-heading9-r-stores-totals-line-6.

      *    Grand total section.
           write counts-and-control-total-line
               from ws-heading10-grand-total-line
               after advancing 1 line.

       200-determine-record.

           add il-transaction-amount        to ws-overall-amount.

      *    Put 'S' or 'L' records in s&l.dat
           if il-sale-and-layaway-transac-88 then

               perform 250-sale-and-layaway-record

      *    Put 'R' records in return.dat
           else if il-return-transac-88

               perform 300-return-record

           end-if
           end-if.

           compute ws-grand-total-calc = ws-s-and-l-total-amount - 
               ws-return-total-amount.
           move ws-grand-total-calc         to ws-total-grand.

           read valid-file
               at end move ws-true-const    to ws-eof-flag.

       250-sale-and-layaway-record.

      *    Increment sale and layway record counter.
           add 1
               to ws-sale-and-layway-count.
           move ws-sale-and-layway-count
               to ws-num-of-s-and-l-records.

      *    Add transaction amount to overall sale and layway
      *    overall total.
           add il-transaction-amount
               to ws-s-and-l-total-amount.
           move ws-s-and-l-total-amount
               to ws-total-s-and-l-amount. 

      *    Do total number of records and amount for 'S' records.
           if il-sale-transac-88 then

      *        Increment sale record counter.
               add 1                        to ws-sale-count
               move ws-sale-count           to ws-num-of-s-records
      *        Add transaction amount to sale overall total
               add il-transaction-amount    to ws-sale-total-amount
               move ws-sale-total-amount
                   to ws-total-s-amount

           end-if.
         
      *    Do total number of records and amount for 'L' records.
           if il-layaway-transac-88 then

      *        Increment layaway record counter.
               add 1                        to ws-layaway-count
               move ws-layaway-count        to ws-num-of-l-records
      *        Add transaction amount to layaway overall total
               add il-transaction-amount    to ws-layaway-total-amount
               move ws-layaway-total-amount
                   to ws-total-l-amount

           end-if.

      *    Calculate transaction amount for each store.
           perform 260-sale-and-layway-stores.

      *    Calculate percentage of transactions in
      *    each payment type.
           perform 270-sale-and-layway-payment-types.

      *    Put this record in the s&l.dat file.
           write sale-and-layaway-line from input-line.

       260-sale-and-layway-stores.

      *    Determine store number and add the record's transaction
      *    amount to that.

           if il-store-01-88 then
               add il-transaction-amount
                   to ws-s-and-l-store-01-total
               move ws-s-and-l-store-01-total
                   to ws-total-s-and-l-01-store
           end-if.

           if il-store-02-88 then
               add il-transaction-amount
                   to ws-s-and-l-store-02-total
               move ws-s-and-l-store-02-total
                   to ws-total-s-and-l-02-store
           end-if.

           if il-store-03-88 then
               add il-transaction-amount
                   to ws-s-and-l-store-03-total
               move ws-s-and-l-store-03-total
                   to ws-total-s-and-l-03-store
           end-if.

           if il-store-04-88 then
               add il-transaction-amount
                   to ws-s-and-l-store-04-total
               move ws-s-and-l-store-04-total
                   to ws-total-s-and-l-04-store
           end-if.

           if il-store-05-88 then
               add il-transaction-amount
                   to ws-s-and-l-store-05-total
               move ws-s-and-l-store-05-total
                   to ws-total-s-and-l-05-store
           end-if.

           if il-store-12-88 then
               add il-transaction-amount
                   to ws-s-and-l-store-12-total
               move ws-s-and-l-store-12-total
                   to ws-total-s-and-l-12-store
           end-if.

       270-sale-and-layway-payment-types.

      *    Determine payment type and add the record's
      *    transaction amount to it then divide by overall
      *    transactiona mount.

           if il-payment-cash-88 then

               add 1                        to ws-cash-count

           end-if.

           if il-payment-credit-88 then

               add 1                        to ws-credit-count

           end-if.

           if il-payment-debit-88 then

               add 1                        to ws-debit-count

           end-if.

           compute ws-cash-percent rounded = ws-cash-count / 
               ws-sale-and-layway-count * 100. 
       
           move ws-cash-percent
               to ws-total-perc-cash.

           compute ws-credit-percent rounded = ws-credit-count / 
               ws-sale-and-layway-count * 100.
       
           move ws-credit-percent
               to ws-total-perc-credit.

           compute ws-debit-percent rounded = ws-debit-count / 
               ws-sale-and-layway-count * 100.
       
           move ws-debit-percent
               to ws-total-perc-debit.

       300-return-record.

      *    Increment return record counter.
           add 1                            to ws-return-count.
           move ws-return-count             to ws-num-of-r-records.
      *    Add transaction amount to return overall total.
           add il-transaction-amount        to ws-return-total-amount.
           move ws-return-total-amount      to ws-total-r-amount.

      *    Determine store number and add the record's transaction
      *    amount to that.
           if il-store-01-88 then
               add il-transaction-amount    to ws-r-store-01-total
               move ws-r-store-01-total     to ws-total-r-01-store    
           end-if.

           if il-store-02-88 then
               add il-transaction-amount    to ws-r-store-02-total
               move ws-r-store-02-total     to ws-total-r-02-store
           end-if.

           if il-store-03-88 then
               add il-transaction-amount    to ws-r-store-03-total
               move ws-r-store-03-total     to ws-total-r-03-store
           end-if.

           if il-store-04-88 then
               add il-transaction-amount    to ws-r-store-04-total
               move ws-r-store-04-total     to ws-total-r-04-store
           end-if.

           if il-store-05-88 then
               add il-transaction-amount    to ws-r-store-05-total
               move ws-r-store-05-total     to ws-total-r-05-store
           end-if.

           if il-store-12-88 then
               add il-transaction-amount    to ws-r-store-12-total
               move ws-r-store-12-total     to ws-total-r-12-store
           end-if.

      *    Put this record in the returns.dat file.
           write return-line from input-line.
           
       end program Program_2.