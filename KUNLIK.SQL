create view VW_DAILY_REPORT_3 as
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1'                                row_no,
             'Активлар'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 1)  = '1')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a

         join
     (select '1'                                row_no,
             'Активлар'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 1)  = '1')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b

     on a.row_no = b.row_no
         join

     (select '1'                                row_no,
             'Активлар'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where substr(ACCOUNT, 1, 1)  = '1'
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join

     (select '1'                                row_no,
             'Активлар'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 1)  = '1')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no

union all

--AKTIV
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.1'                              row_no,
             'Кредит портфель, брутто'          ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join

     (select '1.1'                              row_no,
             'Кредит портфель, брутто'          ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b

     on a.row_no = b.row_no
         join

     (select '1.1'                              row_no,
             'Кредит портфель, брутто'          ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4)
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c

     on a.row_no = c.row_no
         join
     (select '1.1'                              row_no,
             'Кредит портфель, брутто'          ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4))
        and BAL_DATE = to_date(sysdate - 1)
     ) d

     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'Жисмоний'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (((substr(ACCOUNT, 1, 5) >= '12500')
          and (substr(ACCOUNT, 1, 5) < '12600')
          and (substr(ACCOUNT, 1, 5) <> '12599'))
          or ((substr(ACCOUNT, 1, 5) >= '14900')
              and (substr(ACCOUNT, 1, 5) <> '14999')
              and (substr(ACCOUNT, 1, 5) < '15000')))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'Жисмоний'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (((substr(ACCOUNT, 1, 5) >= '12500')
          and (substr(ACCOUNT, 1, 5) < '12600')
          and (substr(ACCOUNT, 1, 5) <> '12599'))
          or ((substr(ACCOUNT, 1, 5) >= '14900')
              and (substr(ACCOUNT, 1, 5) <> '14999')
              and (substr(ACCOUNT, 1, 5) < '15000')))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                row_no,
             'Жисмоний'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (((substr(ACCOUNT, 1, 5) >= '12500')
          and (substr(ACCOUNT, 1, 5) < '12600')
          and (substr(ACCOUNT, 1, 5) <> '12599'))
          or ((substr(ACCOUNT, 1, 5) >= '14900')
              and (substr(ACCOUNT, 1, 5) <> '14999')
              and (substr(ACCOUNT, 1, 5) < '15000')))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                row_no,
             'Жисмоний'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (((substr(ACCOUNT, 1, 5) >= '12500')
          and (substr(ACCOUNT, 1, 5) < '12600')
          and (substr(ACCOUNT, 1, 5) <> '12599'))
          or ((substr(ACCOUNT, 1, 5) >= '14900')
              and (substr(ACCOUNT, 1, 5) <> '14999')
              and (substr(ACCOUNT, 1, 5) < '15000')))
        and BAL_DATE = to_date(sysdate) - 1
     ) d
     on a.row_no = d.row_no

union all

select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'Шу жумладан ипотека кредитлари'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where ACCOUNT in (select distinct REPORTING_ACC from STTM_REPORTLINES_CUSTOM
                        where substr(REFERENCE_NO,4,4) = '1007' and GL_CODE in ('14901001','14901100')
      )
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'Шу жумладан ипотека кредитлари'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where ACCOUNT in (select distinct REPORTING_ACC from STTM_REPORTLINES_CUSTOM
                        where substr(REFERENCE_NO,4,4) = '1007' and GL_CODE in ('14901001','14901100')
      )
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                row_no,
             'Шу жумладан ипотека кредитлари'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where ACCOUNT in (select distinct REPORTING_ACC from STTM_REPORTLINES_CUSTOM
                        where substr(REFERENCE_NO,4,4) = '1007' and GL_CODE in ('14901001','14901100')
      )
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                row_no,
             'Шу жумладан ипотека кредитлари'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where ACCOUNT in (select distinct REPORTING_ACC from STTM_REPORTLINES_CUSTOM
                        where substr(REFERENCE_NO,4,4) = '1007' and GL_CODE in ('14901001','14901100')
      )
        and BAL_DATE = to_date(sysdate) - 1
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                                                                           row_no,
             'Юридик'                                                                                      ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) not like '125%')
        and (substr(ACCOUNT, 1, 5) >= '12100')
        and (substr(ACCOUNT, 1, 5) < '15800')
        and (substr(ACCOUNT, 1, 5) not like '149%')
        and (substr(ACCOUNT, 1, 5) not like '1%99')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                                                                           row_no,
             'Юридик'                                                                                      ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) not like '125%')
        and (substr(ACCOUNT, 1, 5) >= '12100')
        and (substr(ACCOUNT, 1, 5) < '15800')
        and (substr(ACCOUNT, 1, 5) not like '149%')
        and (substr(ACCOUNT, 1, 5) not like '1%99')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                                                                           row_no,
             'Юридик'                                                                                      ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) not like '125%')
        and (substr(ACCOUNT, 1, 5) >= '12100')
        and (substr(ACCOUNT, 1, 5) < '15800')
        and (substr(ACCOUNT, 1, 5) not like '149%')
        and (substr(ACCOUNT, 1, 5) not like '1%99')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                                                                           row_no,
             'Юридик'                                                                                      ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) not like '125%')
        and (substr(ACCOUNT, 1, 5) >= '12100')
        and (substr(ACCOUNT, 1, 5) < '15800')
        and (substr(ACCOUNT, 1, 5) not like '149%')
        and (substr(ACCOUNT, 1, 5) not like '1%99')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.1.1'                                         row_no,
             'муаммоли кредитлар суммаси (NPL)'              ac_desc,
             nvl(round(sum(total_outstanding) / 1000, 2), 0) prev_month
      from loan_npl_by_date
      where to_date(VAL_DT) = to_date(trunc(sysdate - 31, 'MM'))) a
         join
     (select '1.1.1'                                         row_no,
             'муаммоли кредитлар суммаси (NPL)'              ac_desc,
             nvl(round(sum(total_outstanding) / 1000, 2), 0) curr_month
      from loan_npl_by_date
      where to_date(VAL_DT) = to_date(trunc(sysdate, 'MM'))) b
     on a.row_no = b.row_no
         join
     (select '1.1.1'                                         row_no,
             'муаммоли кредитлар суммаси (NPL)'              ac_desc,
             nvl(round(sum(total_outstanding) / 1000, 2), 0) prev_day
      from loan_npl_by_date
      where to_date(VAL_DT) = to_date(case
                                          when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                          else sysdate - 1 end)) c
     on a.row_no = c.row_no
         join
     (select '1.1.1'                                         row_no,
             'муаммоли кредитлар суммаси (NPL)'              ac_desc,
             nvl(round(sum(total_outstanding) / 1000, 2), 0) curr_day
      from loan_npl_by_date
      where to_date(VAL_DT) = to_date(sysdate)) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'Муддати ўтган суммаси'            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 2))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'Муддати ўтган суммаси'            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 2))
        and BAL_DATE = trunc(sysdate, 'MM') -1
     ) b
     on a.ac_desc = b.ac_desc
         join
     (select '-'                                row_no,
             'Муддати ўтган суммаси'            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 2))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.ac_desc = c.ac_desc
         join
     (select '-'                                row_no,
             'Муддати ўтган суммаси'            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 2))
        and BAL_DATE = sysdate - 1
     ) d
     on a.ac_desc = d.ac_desc
union all

select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                              row_no,
             'Ойлик график суммаси'           ac_desc,
             round(sum(amount_due) / 1000, 2) prev_month
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and to_char(schedule_due_date, 'MM-YYYY') = to_char(sysdate - 32, 'MM-YYYY')) a
         join
     (select '-'                              row_no,
             'Ойлик график суммаси'           ac_desc,
             round(sum(amount_due) / 1000, 2) curr_month
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and to_char(schedule_due_date, 'MM-YYYY') = to_char(sysdate, 'MM-YYYY')) b
     on a.ac_desc = b.ac_desc
         join
     (select '-'                              row_no,
             'Ойлик график суммаси'           ac_desc,
             round(sum(amount_due) / 1000, 2) prev_day
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and schedule_due_date between trunc(sysdate, 'MM') and to_date(case
                                                                           when to_char(sysdate, 'D') in (1, 2, 7)
                                                                               then next_day(sysdate - 7, 'Friday')
                                                                           else sysdate - 1 end)) c
     on a.ac_desc = c.ac_desc
         join
     (select '-'                              row_no,
             'Ойлик график суммаси'           ac_desc,
             round(sum(amount_due) / 1000, 2) curr_day
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and schedule_due_date between trunc(sysdate, 'MM') and to_date(sysdate)) d
     on a.ac_desc = d.ac_desc
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                  row_no,
             'Сўндирилгани'                       ac_desc,
             round(sum(amount_settled) / 1000, 2) prev_month
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and to_char(schedule_due_date, 'MM-YYYY') = to_char(sysdate - 32, 'MM-YYYY')) a
         join
     (select '-'                                  row_no,
             'Сўндирилгани'                       ac_desc,
             round(sum(amount_settled) / 1000, 2) curr_month
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and to_char(schedule_due_date, 'MM-YYYY') = to_char(sysdate, 'MM-YYYY')
        and to_char(LAST_PMNT_VALUE_DATE, 'MM-YYYY') = to_char(sysdate, 'MM-YYYY')) b
     on a.ac_desc = b.ac_desc
         join
     (select '-'                                  row_no,
             'Сўндирилгани'                       ac_desc,
             round(sum(amount_settled) / 1000, 2) prev_day
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and schedule_due_date between trunc(sysdate, 'MM') and to_date(case
                                                                           when to_char(sysdate, 'D') in (1, 2, 7)
                                                                               then next_day(sysdate - 7, 'Friday')
                                                                           else sysdate - 1 end)) c
     on a.ac_desc = c.ac_desc
         join
     (select '-'                                  row_no,
             'Сўндирилгани'                       ac_desc,
             round(sum(amount_settled) / 1000, 2) curr_day
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and schedule_due_date between trunc(sysdate, 'MM') and to_date(sysdate)) d
     on a.ac_desc = d.ac_desc
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                                      row_no,
             'Сўндирилмагани'                                         ac_desc,
             round((sum(amount_due) - sum(amount_settled)) / 1000, 2) prev_month
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and to_char(schedule_due_date, 'MM-YYYY') = to_char(sysdate - 32, 'MM-YYYY')) a
         join
     (select '-'                                                      row_no,
             'Сўндирилмагани'                                         ac_desc,
             round((sum(amount_due) - sum(amount_settled)) / 1000, 2) curr_month
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and to_char(schedule_due_date, 'MM-YYYY') = to_char(sysdate, 'MM-YYYY')) b
     on a.ac_desc = b.ac_desc
         join
     (select '-'                                                      row_no,
             'Сўндирилмагани'                                         ac_desc,
             round((sum(amount_due) - sum(amount_settled)) / 1000, 2) prev_day
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and schedule_due_date between trunc(sysdate, 'MM') and to_date(case
                                                                           when to_char(sysdate, 'D') in (1, 2, 7)
                                                                               then next_day(sysdate - 7, 'Friday')
                                                                           else sysdate - 1 end)) c
     on a.ac_desc = c.ac_desc
         join
     (select '-'                                                      row_no,
             'Сўндирилмагани'                                         ac_desc,
             round((sum(amount_due) - sum(amount_settled)) / 1000, 2) curr_day
      from cltb_account_schedules sch
               join cltb_account_master cl on cl.account_number = sch.account_number and account_status = 'A'
      where component_name in ('MAIN_INT', 'PRINCIPAL')
        and schedule_due_date between trunc(sysdate, 'MM') and to_date(sysdate)) d
     on a.ac_desc = d.ac_desc
union all

select a.row_no,
       a.ac_desc,
       d.prev_month,
       c.curr_month,
       b.prev_day,
       a.curr_day
from (select ab.row_no, ab.ac_desc, round(cd.curr_day_npl / ab.curr_day_lp * 100, 1) curr_day
      from (select '1.1.2'                                 row_no,
                   'Муаммоли кредитлар улуши NPL (фоизда)' ac_desc
                    ,
                   abs(sum(LCY_CLOSE_BAL))                       curr_day_lp
            from BALANCE_BY_DATE a
            where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4))
              and BAL_DATE = sysdate - 1
           ) ab
               join
           (select '1.1.2'                                 row_no,
                   'муаммоли кредитлар улуши NPL (фоизда)' ac_desc,
                   nvl(sum(total_outstanding), 0)          curr_day_npl
            from loan_npl_by_date
            where to_date(VAL_DT) = to_date(sysdate)) cd
           on ab.row_no = cd.row_no) a
         join
     (select ab.row_no, ab.ac_desc, round(cd.prev_day_npl / ab.prev_day_lp * 100, 1) prev_day
      from (select '1.1.2'                                 row_no,
                   'муаммоли кредитлар улуши NPL (фоизда)' ac_desc
                    ,
                   abs(sum(LCY_CLOSE_BAL))                       prev_day_lp
            from BALANCE_BY_DATE a
            where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4))
              and BAL_DATE = to_date(case
                                         when to_char(sysdate, 'D') in (1, 2, 7)
                                             then next_day(sysdate - 7, 'Friday')
                                         else sysdate - 1 end) - 1
           ) ab
               join
           (select '1.1.2'                                 row_no,
                   'муаммоли кредитлар улуши NPL (фоизда)' ac_desc,
                   nvl(sum(total_outstanding), 0)          prev_day_npl
            from loan_npl_by_date
            where to_date(VAL_DT) = to_date(case
                                                when to_char(sysdate, 'D') in (1, 2, 7)
                                                    then next_day(sysdate - 7, 'Friday')
                                                else sysdate - 1 end)) cd
           on ab.row_no = cd.row_no) b
     on a.row_no = b.row_no
         join
     (select ab.row_no, ab.ac_desc, round(cd.curr_month_npl / ab.curr_month_lp * 100, 1) curr_month
      from (select '1.1.2'                                 row_no,
                   'муаммоли кредитлар улуши NPL (фоизда)' ac_desc
                    ,
                   abs(sum(LCY_CLOSE_BAL))                       curr_month_lp
            from BALANCE_BY_DATE a
            where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4))
              and BAL_DATE = trunc(sysdate, 'MM') - 1
           ) ab
               join
           (select '1.1.2'                                 row_no,
                   'муаммоли кредитлар улуши NPL (фоизда)' ac_desc,
                   nvl(sum(total_outstanding), 0)          curr_month_npl
            from loan_npl_by_date
            where to_date(VAL_DT) = to_date(trunc(sysdate, 'MM'))) cd
           on ab.row_no = cd.row_no) c
     on a.row_no = c.row_no
         join
     (select ab.row_no, ab.ac_desc, round(cd.prev_month_npl / ab.prev_month_lp * 100, 1) prev_month
      from (select '1.1.2'                                 row_no,
                   'муаммоли кредитлар улуши NPL (фоизда)' ac_desc
                    ,
                   abs(sum(LCY_CLOSE_BAL))                       prev_month_lp
            from BALANCE_BY_DATE a
            where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num <> 4))
              and BAL_DATE = trunc(sysdate - 32, 'MM') - 1
           ) ab
               join
           (select '1.1.2'                                 row_no,
                   'муаммоли кредитлар улуши NPL (фоизда)' ac_desc,
                   nvl(sum(total_outstanding), 0)          prev_month_npl
            from loan_npl_by_date
            where to_date(VAL_DT) = to_date(trunc(sysdate - 32, 'MM'))) cd
           on ab.row_no = cd.row_no) d
     on a.row_no = d.row_no
union all
-- select '1.2'                     row_no,
--        'Кредит фоизлари, брутто' ac_desc,
--        0                         prev_month,
--        0                         curr_month,
--        0                         prev_day,
--        0                         curr_day
-- from dual
-- union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.3'                                         row_no,
             'МБ, бошқа банкларда ва кассадаги маблағлар ' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000,
                   2)                                      prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('101', '103', '105') and
             substr(ACCOUNT, 1, 5) not in ('10599'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.3'                                         row_no,
             'МБ, бошқа банкларда ва кассадаги маблағлар ' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000,
                   2)                                      curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('101', '103', '105') and
             substr(ACCOUNT, 1, 5) not in ('10599'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.3'                                                                                         row_no,
             'МБ, бошқа банкларда ва кассадаги маблағлар '                                                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('101', '103', '105') and
             substr(ACCOUNT, 1, 5) not in ('10599'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.3'                                                                                         row_no,
             'МБ, бошқа банкларда ва кассадаги маблағлар '                                                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('101', '103', '105') and
             substr(ACCOUNT, 1, 5) not in ('10599'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.3.1'                            row_no,
             'МБ вакиллик ҳисобварағи(10301) '  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('10301'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.3.1'                            row_no,
             'МБ вакиллик ҳисобварағи(10301) '  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('10301'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.3.1'                            row_no,
             'МБ вакиллик ҳисобварағи(10301) '  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('10301'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.3.1'                            row_no,
             'МБ вакиллик ҳисобварағи(10301) '  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('10301'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.3.2'                            row_no,
             'Агробанкдаги  маблағлар '         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
            where ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001140' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
               and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
            ) a
         join
     (select '1.3.2'                            row_no,
             'Агробанкдаги  маблағлар '         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
            where ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001140' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
              and BAL_DATE = trunc(sysdate, 'MM') - 1
            ) b
     on a.row_no = b.row_no
         join
     (select '1.3.2'                            row_no,
             'Агробанкдаги  маблағлар '         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
            where ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001140' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
              and BAL_DATE = to_date(case
                                       when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                       else sysdate - 1 end) - 1
            ) c
     on a.row_no = c.row_no
         join
     (select '1.3.2'                            row_no,
             'Агробанкдаги  маблағлар '         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
            where ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001140' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
              and BAL_DATE = to_date(sysdate - 1)
            ) d
     on a.row_no = d.row_no


union all
-- select a.row_no,
--        a.ac_desc,
--        a.prev_month,
--        b.curr_month,
--        c.prev_day,
--        d.curr_day
-- from (select '1.3.3'                            row_no,
--              'Пойтахтбанкдаги  маблағлар '         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
--       from BALANCE_BY_DATE a
--             where ACCOUNT in ('10541000000001172001','10541000100001172002','10541000300001172003')
--                and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
--             ) a
--          join
--      (select '1.3.3'                            row_no,
--              'Пойтахтбанкдаги  маблағлар '         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
--       from BALANCE_BY_DATE a
--             where  ACCOUNT in ('10541000000001172001','10541000100001172002','10541000300001172003')
--               and BAL_DATE = trunc(sysdate, 'MM') - 1
--             ) b
--      on a.row_no = b.row_no
--          join
--      (select '1.3.3'                            row_no,
--              'Пойтахтбанкдаги  маблағлар'         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
--       from BALANCE_BY_DATE a
--             where  ACCOUNT in ('10541000000001172001','10541000100001172002','10541000300001172003')
--               and BAL_DATE = to_date(case
--                                        when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
--                                        else sysdate - 1 end) - 1
--             ) c
--      on a.row_no = c.row_no
--          join
--      (select '1.3.3'                            row_no,
--              'Пойтахтбанкдаги  маблағлар '         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
--       from BALANCE_BY_DATE a
--             where  ACCOUNT in ('10541000000001172001','10541000100001172002','10541000300001172003')
--               and BAL_DATE = to_date(sysdate - 1)
--             ) d
--      on a.row_no = d.row_no
--
--
--
-- union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.3.3'                            row_no,
             'Ҳаётбанкдаги  маблағлар '         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
            where ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001198' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
               and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
            ) a
         join
     (select '1.3.3'                            row_no,
             'Ҳаётбанкдаги  маблағлар '         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
            where ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001198' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
              and BAL_DATE = trunc(sysdate, 'MM') - 1
            ) b
     on a.row_no = b.row_no
         join
     (select '1.3.3'                            row_no,
             'Ҳаётбанкдаги  маблағлар '         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
            where ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001198' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
              and BAL_DATE = to_date(case
                                       when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                       else sysdate - 1 end) - 1
            ) c
     on a.row_no = c.row_no
         join
     (select '1.3.3'                            row_no,
             'Ҳаётбанкдаги  маблағлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
            where  ACCOUNT in (select CUST_AC_NO from STTM_CUST_ACCOUNT where CUST_NO = '00001198' and
                                                                       substr(CUST_AC_NO, 1, 5) in ('10521', '10531', '10541'))
              and BAL_DATE  = to_date(sysdate - 1)
            ) d
     on a.row_no = d.row_no






-- union all
-- select a.row_no,
--        a.ac_desc,
--        a.prev_month,
--        b.curr_month,
--        c.prev_day,
--        d.curr_day
-- from (select '1.4'                              row_no,
--              'Инвестициялар, брутто '           ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('107', '108', '159') and substr(ACCOUNT, 1, 5) not in ('10799', '10899', '15999'))
--               and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
--             ) a
--          join
--      (select '1.4'                              row_no,
--              'Инвестициялар, брутто '           ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('107', '108', '159') and substr(ACCOUNT, 1, 5) not in ('10799', '10899', '15999'))
--               and BAL_DATE = trunc(sysdate, 'MM') - 1
--             ) b
--      on a.row_no = b.row_no
--          join
--      (select '1.4'                              row_no,
--              'Инвестициялар, брутто '           ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('107', '108', '159') and substr(ACCOUNT, 1, 5) not in ('10799', '10899', '15999'))
--               and BAL_DATE = to_date(case
--                                        when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
--                                        else sysdate - 1 end) - 1
--             ) c
--      on a.row_no = c.row_no
--          join
--      (select '1.4'                              row_no,
--              'Инвестициялар, брутто '           ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('107', '108', '159') and substr(ACCOUNT, 1, 5) not in ('10799', '10899', '15999'))
--               and BAL_DATE  = to_date(sysdate - 1)
--             ) d
--      on a.row_no = d.row_no
-- union all
-- select '1.4.1'                  row_no,
--        'муаммоли инвестициялар' ac_desc,
--        0                        prev_month,
--        0                        curr_month,
--        0                        prev_day,
--        0                        curr_day
-- from dual
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.5'                                                   row_no,
             'Асосий воситалар ва номоддий активлар (минус эскириш)' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('165', '166'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.5'                                                   row_no,
             'Асосий воситалар ва номоддий активлар (минус эскириш)' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('165', '166'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.5'                                                   row_no,
             'Асосий воситалар ва номоддий активлар (минус эскириш)' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('165', '166'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.5'                                                   row_no,
             'Асосий воситалар ва номоддий активлар (минус эскириш)' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('165', '166'))
        and BAL_DATE  = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
-- union all
-- select a.row_no,
--        a.ac_desc,
--        a.prev_month,
--        b.curr_month,
--        c.prev_day,
--        d.curr_day
-- from (select '1.5.1'                                             row_no,
--              'банк фаолиятида фойдаланилмаётган кўчмас мулклар ' ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  prev_month
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('167', '168') and substr(ACCOUNT, 1, 5) not in ('16799', '16899'))
--               and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
--             ) a
--          join
--      (select '1.5.1'                                             row_no,
--              'банк фаолиятида фойдаланилмаётган кўчмас мулклар ' ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  curr_month
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('167', '168') and substr(ACCOUNT, 1, 5) not in ('16799', '16899'))
--               and BAL_DATE = trunc(sysdate, 'MM') - 1
--             ) b
--      on a.row_no = b.row_no
--          join
--      (select '1.5.1'                                             row_no,
--              'банк фаолиятида фойдаланилмаётган кўчмас мулклар ' ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  prev_day
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('167', '168') and substr(ACCOUNT, 1, 5) not in ('16799', '16899'))
--               and BAL_DATE = to_date(case
--                                        when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
--                                        else sysdate - 1 end) - 1
--             ) c
--      on a.row_no = c.row_no
--          join
--      (select '1.5.1'                                             row_no,
--              'банк фаолиятида фойдаланилмаётган кўчмас мулклар ' ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  curr_day
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('167', '168') and substr(ACCOUNT, 1, 5) not in ('16799', '16899'))
--               and BAL_DATE = to_date(sysdate - 1)
--             ) d
--      on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.6'                                                                                 row_no,
             'Бошқа активлар, брутто '                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('169', '171', '173', '174', '199'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.6'                                                                                 row_no,
             'Бошқа активлар, брутто '                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('169', '171', '173', '174', '199'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.6'                                                                                 row_no,
             'Бошқа активлар, брутто '                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('169', '171', '173', '174', '199'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.6'                                                                                 row_no,
             'Бошқа активлар, брутто '                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('169', '171', '173', '174', '199'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.6.1'                                                                                 row_no,
             'Дастурий таьминот(19907)'                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) prev_month
      from BALANCE_BY_DATE a
      where ACCOUNT IN (
                        '19907000800001199013',
                        '19907000800001199044',
                        '19907000200001199018',
                        '19907000900001199014',
                        '19907000500001199010',
                        '19907000500001199021',
                        '19907000600001199011'
          )
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.6.1'                                                                                 row_no,
             'Дастурий таьминот(19907)'                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) curr_month
      from BALANCE_BY_DATE a
      where  ACCOUNT IN (
                         '19907000800001199013',
                         '19907000800001199044',
                         '19907000200001199018',
                         '19907000900001199014',
                         '19907000500001199010',
                         '19907000500001199021',
                         '19907000600001199011'
          )
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.6.1'                                                                                 row_no,
             'Дастурий таьминот(19907)'                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) prev_day
      from BALANCE_BY_DATE a
      where  ACCOUNT IN (
                         '19907000800001199013',
                         '19907000800001199044',
                         '19907000200001199018',
                         '19907000900001199014',
                         '19907000500001199010',
                         '19907000500001199021',
                         '19907000600001199011'
          )
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.6.1'                                                                                 row_no,
             'Дастурий таьминот(19907)'                                                             ac_desc,
             abs(round(sum(LCY_CLOSE_BAL) / 1000, 2)) curr_day
      from BALANCE_BY_DATE a
      where  ACCOUNT IN (
                         '19907000800001199013',
                         '19907000800001199044',
                         '19907000200001199018',
                         '19907000900001199014',
                         '19907000500001199010',
                         '19907000500001199021',
                         '19907000600001199011'
          )
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
-- union all
-- select '1.6.1'                           row_no,
--        'банк балансига олинган активлар' ac_desc,
--        0                                 prev_month,
--        0                                 curr_month,
--        0                                 prev_day,
--        0                                 curr_day
-- from dual
-- union all
-- select '1.6.2'                                           row_no,
--        'бўлиб-бўлиб тўлаш шарти билан сотилган активлар' ac_desc,
--        0                                                 prev_month,
--        0                                                 curr_month,
--        0                                                 prev_day,
--        0                                                 curr_day
-- from dual
-- union all
-- select '1.6.3'                   row_no,
--        'бошқа муаммоли активлар' ac_desc,
--        0                         prev_month,
--        0                         curr_month,
--        0                         prev_day,
--        0                         curr_day
-- from dual
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.7'                              row_no,
             'Активлар бўйича захира'           ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599') or
             substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.7'                              row_no,
             'Активлар бўйича захира'           ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599') or
             substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.7'                              row_no,
             'Активлар бўйича захира'           ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599') or
             substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.7'                              row_no,
             'Активлар бўйича захира'           ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599') or
             substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.7.1'                            row_no,
             'кредит ва фоизлар бўйича захира'  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.7.1'                            row_no,
             'кредит ва фоизлар бўйича захира'  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.7.1'                            row_no,
             'кредит ва фоизлар бўйича захира'  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.7.1'                            row_no,
             'кредит ва фоизлар бўйича захира'  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in (select distinct gl_code from loan_shpora where num = 4))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '1.7.2'                              row_no,
             'стандарт активлар бўйича захиралар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '1.7.2'                              row_no,
             'стандарт активлар бўйича захиралар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '1.7.2'                              row_no,
             'стандарт активлар бўйича захиралар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '1.7.2'                              row_no,
             'стандарт активлар бўйича захиралар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('17701', '17705', '10599'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
--MAJBURIYAT
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.1'                                                                                         row_no,
             'Депозитлар'                                                                                  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in
             ('20206','20214','20216','20608', '20406', '20606', '22616', '22618', '20208', '20218', '20408', '20608', '20418', '22619', '22642', '22696', '22620'
                 ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.1'                                                                                         row_no,
             'Депозитлар'                                                                                  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in
             ('20206','20214','20216','20608', '20406', '20606', '22616', '22618', '20208', '20218', '20408', '20608', '20418', '22619', '22642','22696', '22620'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.1'                                                                                         row_no,
             'Депозитлар'                                                                                  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in
             ('20206','20214','20216','20608', '20406', '20606', '22616', '22618', '20208', '20218', '20408', '20608', '20418', '22619', '22642','22696', '22620'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.1'                                                                                         row_no,
             'Депозитлар'                                                                                  ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in
             ('20206','20214','20216','20608', '20406', '20606', '22616', '22618', '20208', '20218', '20408', '20608', '20418', '22619', '22642','22696', '22620'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.1.1'                            row_no,
             'жисмоний шахслар'                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20206', '20406', '20606', '22616', '22618', '22642'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.1.1'                            row_no,
             'жисмоний шахслар'                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20206', '20406', '20606', '22616', '22618', '22642'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.1.1'                            row_no,
             'жисмоний шахслар'                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20206', '20406', '20606', '22616', '22618', '22642'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.1.1'                       row_no,
             'жисмоний шахслар'            ac_desc,
             round(sum(LCY_CLOSE_BAL) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20206', '20406', '20606', '22616', '22618', '22642'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all

select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.1.1.a'                            row_no,
             'Ишончли бошқарув'                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
               join sttm_cust_account b
                    on a.ACCOUNT = b.CUST_AC_NO
      where (substr(ACCOUNT, 1, 5) in ('22642'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1 and substr(CUST_NO,1 , 1) in ('6')
     ) a
         join
     (select '2.1.1.a'                            row_no,
             'Ишончли бошқарув'                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
               join sttm_cust_account b on a.ACCOUNT = b.CUST_AC_NO
      where (substr(ACCOUNT, 1, 5) in ('22642'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1 and substr(CUST_NO,1 , 1) in ('6')
     ) b
     on a.row_no = b.row_no
         join
     (select '2.1.1.a'                            row_no,
             'Ишончли бошқарув'                 ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
               join sttm_cust_account b on a.ACCOUNT = b.CUST_AC_NO
      where (substr(ACCOUNT, 1, 5) in ('22642'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1 and substr(CUST_NO,1 , 1) in ('6')
     ) c
     on a.row_no = c.row_no
         join
     (select '2.1.1.a'                       row_no,
             'Ишончли бошқарув'            ac_desc,
             round(sum(LCY_CLOSE_BAL) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
               join sttm_cust_account b on a.ACCOUNT = b.CUST_AC_NO
      where (substr(ACCOUNT, 1, 5) in ('22642'))
        and BAL_DATE = to_date(sysdate - 1) and substr(CUST_NO,1 , 1) in ('6')
     ) d
     on a.row_no = d.row_no

union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.1.2'                                                                                       row_no,
             'юридик шахслар '                                                                             ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20208', '20218', '20408', '20608', '20418', '22619','20214','20216', '22696', '22620'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.1.2'                                                                                       row_no,
             'юридик шахслар '                                                                             ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20208', '20218', '20408', '20608', '20418', '22619','20214','20216', '22696', '22620'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.1.2'                                                                                       row_no,
             'юридик шахслар '                                                                             ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20208', '20218', '20408', '20608', '20418', '22619','20214','20216', '22696', '22620'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.1.2'                                                                                  row_no,
             'юридик шахслар '                                                                        ac_desc,
             round(sum(LCY_CLOSE_BAL) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('20208', '20218', '20408', '20608', '20418', '22619','20214','20216', '22696', '22620'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.2'                              row_no,
             'Бошқа банкларнинг депозитлари '   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('210', '214', '208'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.2'                              row_no,
             'Бошқа банкларнинг депозитлари '   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('210', '214', '208'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.2'                              row_no,
             'Бошқа банкларнинг депозитлари '   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('210', '214', '208'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.2'                            row_no,
             'Бошқа банкларнинг депозитлари ' ac_desc,
             round(sum(LCY_CLOSE_BAL) / 1000, 2)    curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('210', '214', '208'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all



select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.2.1'                              row_no,
             'Агробанк жойлаштирган депозитлар'   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('21042'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.2.1'                              row_no,
             'Агробанк жойлаштирган депозитлар '   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('21042'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.2.1'                              row_no,
             'Агробанк жойлаштирган депозитлар '   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('21042'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.2.1'                            row_no,
             'Агробанк жойлаштирган депозитлар ' ac_desc,
             round(sum(LCY_CLOSE_BAL) / 1000, 2)    curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 5) in ('21042'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all


select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.3'                             row_no,
             'Тўланиши лозим бўлган кредитлар' ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)),
                 0)                            prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('216'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.3'                             row_no,
             'Тўланиши лозим бўлган кредитлар' ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)),
                 0)                            curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('216'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.3'                                                                                              row_no,
             'Тўланиши лозим бўлган кредитлар'                                                                  ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('216'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.3'                                                                                              row_no,
             'Тўланиши лозим бўлган кредитлар'                                                                  ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('216'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no

-- union all
-- select a.row_no,
--        a.ac_desc,
--        a.prev_month,
--        b.curr_month,
--        c.prev_day,
--        d.curr_day
-- from (select '2.4'                                   row_no,
--              'Субординар қарз'                       ac_desc,
--              nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) prev_month
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('237'))
--               and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
--             ) a
--          join
--      (select '2.4'                                   row_no,
--              'Субординар қарз'                       ac_desc,
--              nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) curr_month
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('237'))
--               and BAL_DATE = trunc(sysdate, 'MM') - 1
--             ) b
--      on a.row_no = b.row_no
--          join
--      (select '2.4'                                   row_no,
--              'Субординар қарз'                       ac_desc,
--              nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) prev_day
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('237'))
--               and BAL_DATE = to_date(case
--                                        when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
--                                        else sysdate - 1 end) - 1
--             ) c
--      on a.row_no = c.row_no
--          join
--      (select '2.4'                                   row_no,
--              'Субординар қарз'                       ac_desc,
--              nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) curr_day
--       from BALANCE_BY_DATE a
--             where (substr(ACCOUNT, 1, 3) in ('237'))
--               and BAL_DATE = to_date(sysdate - 1)
--             ) d
--      on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.5'                                   row_no,
             'Бошқа мажбуриятлар'                    ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in
             ('220', '214', '221', '223', '224', '225', '228', '231', '232', '234', '235', '236', '298', '220')
          or substr(ACCOUNT, 1, 5) in
             ('20202', '20203', '20204', '20210', '20212', '20296', '20402', '20403', '20404',
              '20245', '20616',
              '20410', '20412', '20414', '20416', '20496', '20602', '20603', '20604', '20605', '20610', '20612',
              '20614', '20696', '22614', '22613'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.5'                                   row_no,
             'Бошқа мажбуриятлар'                    ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in
             ('220', '214', '221', '223', '224', '225', '228', '231', '232', '234', '235', '236', '298', '220')
          or substr(ACCOUNT, 1, 5) in
             ('20202', '20203', '20204', '20210', '20212', '20296', '20402', '20403', '20404',
              '20245', '20616',
              '20410', '20412', '20414', '20416', '20496', '20602', '20603', '20604', '20605', '20610', '20612',
              '20614', '20696', '22614', '22613'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.5'                                   row_no,
             'Бошқа мажбуриятлар'                    ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in
             ('220', '214', '221', '223', '224', '225', '228', '231', '232', '234', '235', '236', '298', '220')
          or substr(ACCOUNT, 1, 5) in
             ('20202', '20203', '20204', '20210', '20212', '20296', '20402', '20403', '20404',
              '20245', '20616',
              '20410', '20412', '20414', '20416', '20496', '20602', '20603', '20604', '20605', '20610', '20612',
              '20614', '20696', '22614', '22613'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.5'                                   row_no,
             'Бошқа мажбуриятлар'                    ac_desc,
             nvl((round(sum(LCY_CLOSE_BAL) / 1000, 2)), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in
             ('220', '214', '221', '223', '224', '225', '228', '231', '232', '234', '235', '236', '298')
          or substr(ACCOUNT, 1, 5) in
             ('20202', '20203', '20204', '20210', '20212',  '20296', '20402', '20403', '20404',
              '20245', '20616',
              '20410', '20412', '20414', '20416', '20496', '20602', '20603', '20604', '20605', '20610', '20612',
              '20614', '20696', '22614', '22613'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
-- select '2.5.1'                              row_no,
--        'стандарт активлар бўйича захиралар' ac_desc,
--        0                                    prev_month,
--        0                                    curr_month,
--        0                                    prev_day,
--        0                                    curr_day
-- from dual
-- union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '2.6'                                 row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '22896000800001199001'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '2.6'                                 row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '22896000800001199001'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '2.6'                                 row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '22896000800001199001'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '2.6'                                 row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '22896000800001199001'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
--kapital
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '3.1'                              row_no,
             'Устав капитали'                   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('303'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '3.1'                              row_no,
             'Устав капитали'                   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('303'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '3.1'                              row_no,
             'Устав капитали'                   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('303'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '3.1'                              row_no,
             'Устав капитали'                   ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('303'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '3.2'                                      row_no,
             'Захира ва бошқа капитал '                 ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('306', '309'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '3.2'                                      row_no,
             'Захира ва бошқа капитал '                 ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('306', '309'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '3.2'                                      row_no,
             'Захира ва бошқа капитал '                 ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('306', '309'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '3.2'                                      row_no,
             'Захира ва бошқа капитал '                 ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('306', '309'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '3.3'                                      row_no,
             'Тақсимланмаган фойда (31200)'             ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('312'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '3.3'                                      row_no,
             'Тақсимланмаган фойда (31200)'             ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('312'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '3.3'                                      row_no,
             'Тақсимланмаган фойда (31200)'             ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('312'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '3.3'                                      row_no,
             'Тақсимланмаган фойда (31200)'             ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) in ('312'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '3.4'                                      row_no,
             'Йил бошидан соф фойда (зарар) '           ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 1) in ('4', '5'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '3.4'                                      row_no,
             'Йил бошидан соф фойда (зарар) '           ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 1) in ('4', '5'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '3.4'                                      row_no,
             'Йил бошидан соф фойда (зарар) '           ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 1) in ('4', '5'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '3.4'                                      row_no,
             'Йил бошидан соф фойда (зарар) '           ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 1) in ('4', '5'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
--DAROMAD
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.1'                                      row_no,
             'фоизли даромадлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '402' and '451')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.1'                                      row_no,
             'фоизли даромадлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '402' and '451')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.1'                                      row_no,
             'фоизли даромадлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '402' and '451')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.1'                                      row_no,
             'фоизли даромадлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '402' and '451')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2'                                      row_no,
             'фоизсиз даромадлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '452' and '459')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2'                                      row_no,
             'фоизсиз даромадлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '452' and '459')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2'                                      row_no,
             'фоизсиз даромадлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '452' and '459')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 2 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2'                                      row_no,
             'фоизсиз даромадлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '452' and '459')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.1'                            row_no,
             'Депозитлардан даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199007',
                         '45294000800001199001',
                         '45294000700001199006'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.1'                            row_no,
             'Депозитлардан даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199007',
                         '45294000800001199001',
                         '45294000700001199006'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.1'                            row_no,
             'Депозитлардан даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199007',
                         '45294000800001199001',
                         '45294000700001199006'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.1'                            row_no,
             'Депозитлардан даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199007',
                         '45294000800001199001',
                         '45294000700001199006'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
-- a
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.1.a'                            row_no,
             'Агробанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000800001199001'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.1.a'                            row_no,
             'Агробанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000800001199001'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.1.a'                            row_no,
             'Агробанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000800001199001'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.1.a'                            row_no,
             'Агробанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000800001199001'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no

union all

select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.1.b'                            row_no,
             'Ҳаётбанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000700001199006'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.1.b'                            row_no,
             'Ҳаётбанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000700001199006'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.1.b'                            row_no,
             'Ҳаётбанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000700001199006'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.1.b'                            row_no,
             'Ҳаётбанкдан олинган  даромадлар'         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000700001199006'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no



-- union all
--
--
-- -------1906
--     select a.row_no,
--        a.ac_desc,
--        a.prev_month,
--        b.curr_month,
--        c.prev_day,
--        d.curr_day
-- from (select '4.2.1.с'                            row_no,
--              'Пойтахтбанкдан олинган  даромадлар'         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--                 '45294000900001199007'
--                 ))
--               and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
--             ) a
--          join
--      (select '4.2.1.с'                            row_no,
--              'Пойтахтбанкдан олинган  даромадлар'         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--                 '45294000900001199007'
--                 ))
--               and BAL_DATE = trunc(sysdate, 'MM') - 1
--             ) b
--      on a.row_no = b.row_no
--          join
--      (select '4.2.1.с'                            row_no,
--              'Пойтахтбанкдан олинган  даромадлар'         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--                 '45294000900001199007'
--                 ))
--               and BAL_DATE = to_date(case
--                                        when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
--                                        else sysdate - 1 end) - 1
--             ) c
--      on a.row_no = c.row_no
--          join
--      (select '4.2.1.с'                            row_no,
--              'Пойтахтбанкдан олинган  даромадлар'         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--                 '45294000900001199007'
--                 ))
--               and BAL_DATE = to_date(sysdate - 1)
--             ) d
--      on a.row_no = d.row_no



union all
-- 4.2.2
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.2'                                             row_no,
             'Чакана,корпоратив ва бошқа хизматдан олинган даромадлар'    ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT not like '45294%001') and (ACCOUNT not in ('45294000700001199006','45294000900001199007', '45294000300001199018'))
        and (ACCOUNT like '4%')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.2'                                             row_no,
             'Чакана,корпоратив ва бошқа хизматдан олинган даромадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT not like '45294%001') and (ACCOUNT not in ('45294000700001199006','45294000900001199007', '45294000300001199018'))
        and (ACCOUNT like '4%')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.2'                                             row_no,
             'Чакана,корпоратив ва бошқа хизматдан олинган даромадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT not like '45294%001') and (ACCOUNT not in ('45294000700001199006','45294000900001199007', '45294000300001199018'))
        and (ACCOUNT like '4%')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.2'                                             row_no,
             'Чакана,корпоратив ва бошқа хизматдан олинган даромадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                  curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT not like '45294%001') and (ACCOUNT not in ('45294000700001199006','45294000900001199007', '45294000300001199018'))
        and (ACCOUNT like '4%')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
-- 4.3
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.2.a'                                    row_no,
             'Корпоратив бизнесдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)       prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199015',
                         '45294000100001199840',
                         '45294000200001199017',
                         '45294000100001199016',
                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.2.a'                                    row_no,
             'Корпоратив бизнесдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)       curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199015',
                         '45294000100001199840',
                         '45294000200001199017',
                         '45294000100001199016',
                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.2.a'                                    row_no,
             'Корпоратив бизнесдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)       prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199015',
                         '45294000100001199840',
                         '45294000200001199017',
                         '45294000100001199016',
                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.2.a'                                    row_no,
             'Корпоратив бизнесдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)       curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000900001199015',
                         '45294000100001199840',
                         '45294000200001199017',
                         '45294000100001199016',
                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no

union all------------boshlanishi
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                  row_no,
             'ITFC линияси буйича маржинал фойда' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294000900001199015')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                  row_no,
             'ITFC линияси буйича маржинал фойда' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294000900001199015')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                  row_no,
             'ITFC линияси буйича маржинал фойда' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294000900001199015')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                  row_no,
             'ITFC линияси буйича маржинал фойда' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294000900001199015')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no


union all
-- -
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                  row_no,
             'ITFC линияси буйича комиссио тулов' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%840')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                  row_no,
             'ITFC линияси буйича комиссио тулов' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%840')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                  row_no,
             'ITFC линияси буйича комиссио тулов' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%840')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                  row_no,
             'ITFC линияси буйича комиссио тулов' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%840')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all

select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                  row_no,
             'Муддатли карз' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45294000100001199016', '45294000200001199017'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                  row_no,
             'Муддатли карз' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45294000100001199016', '45294000200001199017'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                  row_no,
             'Муддатли карз' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45294000100001199016', '45294000200001199017'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                  row_no,
             'Муддатли карз' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)   curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45294000100001199016', '45294000200001199017'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no


---------------davomi
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                                     row_no,
             'Бошка  Корпоратив бизнесдан фоизсиз олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                                     row_no,
             'Бошка  Корпоратив бизнесдан фоизсиз олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                                     row_no,
             'Бошка  Корпоратив бизнесдан фоизсиз олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                                     row_no,
             'Бошка  Корпоратив бизнесдан фоизсиз олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)                      curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45994000900001199001',
                         '45249000200001199004'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no

union all
-- 4.4
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.2.b'                                 row_no,
             'Чакана бизнесдан олинган даромадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000200001199777',
                         '45265000600001199005',
                         '45294000500001199005',
                         '45249000400001199812',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45233000500001199101',
                         '45265000700001199010',
                         '45265000900001199001',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000900001199012',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45265000000001199007',
                         '45265000300001199009',
                         '45249000400001199005',
                         '45265000800001199600',
                         '45405000700001199600',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013',
                         '45249000700001199001',
                         '45265000200001199003',
                         '45249000000001199800',
                         '45265000000001199112',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45253000200001199704',
                         '45253000300001199860',
                         '45253000600001199410',
                         '45253000600001199730',
                         '45405000000001199410',
                         '45405000000001199730',
                         '45405000600001199704',
                         '45405000700001199715',
                         '45405000900001199800'



          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.2.b'                                 row_no,
             'Чакана бизнесдан олинган даромадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000200001199777',
                         '45265000600001199005',
                         '45294000500001199005',
                         '45249000400001199812',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45233000500001199101',
                         '45265000700001199010',
                         '45265000900001199001',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000900001199012',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45265000000001199007',
                         '45265000300001199009',
                         '45249000400001199005',
                         '45265000800001199600',
                         '45405000700001199600',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013',
                         '45249000700001199001',
                         '45265000200001199003',
                         '45249000000001199800',
                         '45265000000001199112',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45253000200001199704',
                         '45253000300001199860',
                         '45253000600001199410',
                         '45253000600001199730',
                         '45405000000001199410',
                         '45405000000001199730',
                         '45405000600001199704',
                         '45405000700001199715',
                         '45405000900001199800'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.2.b'                                 row_no,
             'Чакана бизнесдан олинган даромадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000200001199777',
                         '45265000600001199005',
                         '45294000500001199005',
                         '45249000400001199812',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45233000500001199101',
                         '45265000700001199010',
                         '45265000900001199001',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000900001199012',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45265000000001199007',
                         '45265000300001199009',
                         '45249000400001199005',
                         '45265000800001199600',
                         '45405000700001199600',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013',
                         '45249000700001199001',
                         '45265000200001199003',
                         '45249000000001199800',
                         '45265000000001199112',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45253000200001199704',
                         '45253000300001199860',
                         '45253000600001199410',
                         '45253000600001199730',
                         '45405000000001199410',
                         '45405000000001199730',
                         '45405000600001199704',
                         '45405000700001199715',
                         '45405000900001199800'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.2.b'                                 row_no,
             'Чакана бизнесдан олинган даромадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45294000200001199777',
                         '45265000600001199005',
                         '45294000500001199005',
                         '45249000400001199812',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45233000500001199101',
                         '45265000700001199010',
                         '45265000900001199001',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000900001199012',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45265000000001199007',
                         '45265000300001199009',
                         '45249000400001199005',
                         '45265000800001199600',
                         '45405000700001199600',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013',
                         '45249000700001199001',
                         '45265000200001199003',
                         '45249000000001199800',
                         '45265000000001199112',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45253000200001199704',
                         '45253000300001199860',
                         '45253000600001199410',
                         '45253000600001199730',
                         '45405000000001199410',
                         '45405000000001199730',
                         '45405000600001199704',
                         '45405000700001199715',
                         '45405000900001199800'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'P2P дан олинган даромадлар'       ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45265000000001199007',
                         '45265000300001199009',
                         '45265000900001199012',
                         '45265000900001199001',
                         '45265000200001199003',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45265000000001199112'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'P2P дан олинган даромадлар'       ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45265000000001199007',
                         '45265000300001199009',
                         '45265000900001199012',
                         '45265000900001199001',
                         '45265000200001199003',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45265000000001199112'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                row_no,
             'P2P дан олинган даромадлар'       ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45265000000001199007',
                         '45265000300001199009',
                         '45265000900001199012',
                         '45265000900001199001',
                         '45265000200001199003',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45265000000001199112'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                row_no,
             'P2P дан олинган даромадлар'       ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45265000000001199007',
                         '45265000300001199009',
                         '45265000900001199012',
                         '45265000900001199001',
                         '45265000200001199003',
                         '45265000500001199019',
                         '45265000700001199025',
                         '45265000700001199027',
                         '45265000000001199112'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
-- Муддатли туловдан олинган дармадлар
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                   row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%777')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                   row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%777')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                   row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%777')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                   row_no,
             'Муддатли туловдан олинган дармадлар' ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2)    curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45294%777')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
-- -
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'Пайнетдан'                        ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45265000600001199005')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'Пайнетдан'                        ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45265000600001199005')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                row_no,
             'Пайнетдан'                        ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45265000600001199005')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                row_no,
             'Пайнетдан'                        ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT like '45265000600001199005')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'MUNIS'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45249000400001199005', '45249000700001199001', '45249000000001199800', '45249000000001199800'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'MUNIS'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45249000400001199005', '45249000700001199001', '45249000000001199800', '45249000000001199800'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                row_no,
             'MUNIS'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45249000400001199005', '45249000700001199001', '45249000000001199800', '45249000000001199800'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                row_no,
             'MUNIS'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45249000400001199005', '45249000700001199001', '45249000000001199800', '45249000000001199800'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no

union all

select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'ХПЎ бўйича даромад'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT  in ('45405000700001199600','45265000800001199600',
                          '45253000200001199704',
                          '45253000300001199860',
                          '45253000600001199410',
                          '45253000600001199730',
                          '45405000000001199410',
                          '45405000000001199730',
                          '45405000600001199704',
                          '45405000700001199715',
                          '45405000900001199800'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'ХПЎ бўйича даромад'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT  in ('45405000700001199600','45265000800001199600',
                          '45253000200001199704',
                          '45253000300001199860',
                          '45253000600001199410',
                          '45253000600001199730',
                          '45405000000001199410',
                          '45405000000001199730',
                          '45405000600001199704',
                          '45405000700001199715',
                          '45405000900001199800'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                row_no,
             'ХПЎ бўйича даромад'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT  in ('45405000700001199600','45265000800001199600',
                          '45253000200001199704',
                          '45253000300001199860',
                          '45253000600001199410',
                          '45253000600001199730',
                          '45405000000001199410',
                          '45405000000001199730',
                          '45405000600001199704',
                          '45405000700001199715',
                          '45405000900001199800'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                row_no,
             'ХПЎ бўйича даромад'                            ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in ('45405000700001199600','45265000800001199600',
                         '45253000200001199704',
                         '45253000300001199860',
                         '45253000600001199410',
                         '45253000600001199730',
                         '45405000000001199410',
                         '45405000000001199730',
                         '45405000600001199704',
                         '45405000700001199715',
                         '45405000900001199800'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
-- -	Бошкалар chakana
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '-'                                row_no,
             'Бошкалар (чакана)'                ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45233000500001199101',
                         '45265000700001199010',
                         '45294000500001199005',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45249000400001199812',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013'
          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '-'                                row_no,
             'Бошкалар (чакана)'                ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45233000500001199101',
                         '45265000700001199010',
                         '45294000500001199005',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45249000400001199812',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '-'                                row_no,
             'Бошкалар (чакана)'                ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45233000500001199101',
                         '45265000700001199010',
                         '45294000500001199005',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45249000400001199812',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '-'                                row_no,
             'Бошкалар (чакана)'                ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45233000500001199101',
                         '45265000700001199010',
                         '45294000500001199005',
                         '45265000300001199017',
                         '45265000400001199018',
                         '45265000700001199022',
                         '45265000800001199011',
                         '45265000100001199008',
                         '45265000000001199013',
                         '45265000800001199006',
                         '45249000400001199812',
                         '45294000200001199009',
                         '45294000800001199012',
                         '45294000900001199013'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
-- union all
-- -- 4.5
-- -- -	Бошкалар_4
-- select a.row_no,
--        a.ac_desc,
--        a.prev_month,
--        b.curr_month,
--        c.prev_day,
--        d.curr_day
-- from (select '4.2.2.c'                                                          row_no,
--              'Standard Chartered дан олинган даромад'                       ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--                             '45294000700001199011', '45294000600001199010'
--
--
--
--
--                 ))
--               and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
--             ) a
--          join
--      (select '4.2.2.c'                                                            row_no,
--              'Standard Chartered дан олинган даромад'                         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--
--                             '45294000700001199011', '45294000600001199010'
--                 ))
--               and BAL_DATE = trunc(sysdate, 'MM') - 1
--             ) b
--      on a.row_no = b.row_no
--          join
--      (select '4.2.2.c'                                                            row_no,
--              'Standard Chartered дан олинган даромад'                         ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--
--                             '45294000700001199011', '45294000600001199010'
--                 ))
--               and BAL_DATE = to_date(case
--                                        when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
--                                        else sysdate - 1 end) - 1
--             ) c
--      on a.row_no = c.row_no
--          join
--      (select '4.2.2.c'                                                          row_no,
--              'Standard Chartered дан олинган даромад'                       ac_desc,
--              round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
--       from BALANCE_BY_DATE a
--             where (ACCOUNT in (
--
--                             '45294000700001199011', '45294000600001199010'
--                 ))
--               and BAL_DATE = to_date(sysdate - 1)
--             ) d
--      on a.row_no = d.row_no

union all




-- 4.5
-- -	Бошкалар_4
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.2.c'                                row_no,
             'Бошкалар'                           ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
                         '45401000800001199001',
                         '45405000500001199500',
                         '45405000200001199550',
                         '45265000100001199015',
                         '45265000900001199002',
                         '45265000900001199014',
                         '45403000800001199001',
                         '45921000700001199001',
                         '45994000900001199111',
                         '45994000900001199002',
                         '45294000900001199008',

          --'45265000200001199003',
                         '45265000700001199023',
                         '45265000700001199024'



--




          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.2.c'                                row_no,
             'Бошкалар'                           ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45401000800001199001',
                         '45405000500001199500',
                         '45405000200001199550',
                         '45265000100001199015',
                         '45265000900001199002',
                         '45265000900001199014',
                         '45403000800001199001',
                         '45921000700001199001',
                         '45994000900001199111',
                         '45994000900001199002',
                         '45294000900001199008',

          --'45265000200001199003',
                         '45265000700001199023',
                         '45265000700001199024'
--                             '45401000200001199777',
--                             '45401000300001199779',
--                             '45401000800001199778',

          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.2.c'                                row_no,
             'Бошкалар'                           ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45401000800001199001',
                         '45405000500001199500',
                         '45405000200001199550',
                         '45265000100001199015',
                         '45265000900001199002',
                         '45265000900001199014',
                         '45403000800001199001',
                         '45921000700001199001',
                         '45994000900001199111',
                         '45994000900001199002',
                         '45294000900001199008',

          --'45265000200001199003',
                         '45265000700001199023',
                         '45265000700001199024'
--                             '45401000200001199777',
--                             '45401000300001199779',
--                             '45401000800001199778'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.2.c'                                row_no,
             'Бошкалар'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

                         '45401000800001199001',
                         '45405000500001199500',
                         '45405000200001199550',
                         '45265000100001199015',
                         '45265000900001199002',
                         '45265000900001199014',
                         '45403000800001199001',
                         '45921000700001199001',
                         '45994000900001199111',
                         '45994000900001199002',
                         '45294000900001199008',

          --'45265000200001199003',
                         '45265000700001199023',
                         '45265000700001199024'
          --'45401000200001199777',
          --'45401000300001199779',
          --'45401000800001199778'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no

union all


select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '4.2.3'                                                          row_no,
             'Агробанк муддатли тулов'                       ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (
          '45294000300001199018'




          ))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '4.2.3'                                                            row_no,
             'Агробанк муддатли тулов'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_month
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

          '45294000300001199018'
          ))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '4.2.3'                                                            row_no,
             'Агробанк муддатли тулов'                         ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) prev_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

          '45294000300001199018'
          ))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '4.2.3'                                                          row_no,
             'Агробанк муддатли тулов'                       ac_desc,
             round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2) curr_day
      from BALANCE_BY_DATE a
      where (ACCOUNT in (

          '45294000300001199018'
          ))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no


union all

select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '5.1'                                      row_no,
             'фоизли харажатлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '501' and '549')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '5.1'                                      row_no,
             'фоизли харажатлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '501' and '549')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '5.1'                                      row_no,
             'фоизли харажатлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '501' and '549')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '5.1'                                      row_no,
             'фоизли харажатлар'                        ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '501' and '549')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '5.2'                                      row_no,
             'фоизсиз харажатлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '551' and '559')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '5.2'                                      row_no,
             'фоизсиз харажатлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '551' and '559')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '5.2'                                      row_no,
             'фоизсиз харажатлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '551' and '559')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '5.2'                                      row_no,
             'фоизсиз харажатлар'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where (substr(ACCOUNT, 1, 3) between '551' and '559')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '5.2.1'                                      row_no,
             'Дастурий таьминот харажатлари'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where ACCOUNT in  ('55195000400001199108')
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '5.2.1'                                      row_no,
             'Дастурий таьминот харажатлари
'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where ACCOUNT in  ('55195000400001199108')
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '5.2.1'                                      row_no,
             'Дастурий таьминот харажатлари'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where ACCOUNT in  ('55195000400001199108')
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '5.2.1'                                      row_no,
             'Дастурий таьминот харажатлари'                       ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where ACCOUNT in  ('55195000400001199108')
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
union all
select a.row_no,
       a.ac_desc,
       a.prev_month,
       b.curr_month,
       c.prev_day,
       d.curr_day
from (select '5.3'                                      row_no,
             'операцион харажатлар'                     ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_month
      from BALANCE_BY_DATE a
      where ((substr(ACCOUNT, 1, 3) between '561' and '569') or substr(ACCOUNT, 1, 5) in ('57701', '57705'))
        and BAL_DATE = trunc(sysdate - 31, 'MM') - 1
     ) a
         join
     (select '5.3'                                      row_no,
             'операцион харажатлар'                     ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_month
      from BALANCE_BY_DATE a
      where ((substr(ACCOUNT, 1, 3) between '561' and '569') or substr(ACCOUNT, 1, 5) in ('57701', '57705'))
        and BAL_DATE = trunc(sysdate, 'MM') - 1
     ) b
     on a.row_no = b.row_no
         join
     (select '5.3'                                      row_no,
             'операцион харажатлар'                     ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) prev_day
      from BALANCE_BY_DATE a
      where ((substr(ACCOUNT, 1, 3) between '561' and '569') or substr(ACCOUNT, 1, 5) in ('57701', '57705'))
        and BAL_DATE = to_date(case
                                   when to_char(sysdate, 'D') in (1, 2, 7) then next_day(sysdate - 7, 'Friday')
                                   else sysdate - 1 end) - 1
     ) c
     on a.row_no = c.row_no
         join
     (select '5.3'                                      row_no,
             'операцион харажатлар'                     ac_desc,
             nvl(round(abs(sum(LCY_CLOSE_BAL)) / 1000, 2), 0) curr_day
      from BALANCE_BY_DATE a
      where ((substr(ACCOUNT, 1, 3) between '561' and '569') or substr(ACCOUNT, 1, 5) in ('57701', '57705'))
        and BAL_DATE = to_date(sysdate - 1)
     ) d
     on a.row_no = d.row_no
/

