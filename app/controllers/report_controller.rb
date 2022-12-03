class ReportController < ApplicationController
  def customer_with_max_bills
    sql = 'select "first_name", "second_name", "mobile_number" from "customers"
          inner join "bills" on "customers"."id" = "bills"."customer_id"
          group by "customer_id", "first_name", "second_name", "mobile_number"
          having  count("customer_id") = (select count("customer_id") from "bills" group by "customer_id");' #TODO check later
    render json: ActiveRecord::Base.connection.execute(sql)
  end

  def deposite_bills
    sql = 'select "bill_num","type_name", "date_last_accrual_per" from "bills"
          inner join "bill_types" on "bills"."type_id" = "bill_types"."id"
          where "type_name" = ' + 'deposite' + '
          group by "type_name", "bill_num", "date_last_accrual_per"
          having  "date_last_accrual_per" >  (SELECT add_months( CURRENT_DATE, -6 ) FROM DUAL);'
    render json: ActiveRecord::Base.connection.execute(sql)
  end

  def cost_moving(num)
    sql = 'select  "operations"."id", "bills"."id", "date_operation_about_bill" from "operations"
          inner join "bills" on "operations"."bill_id_source" = "bills"."id"
          where "bills"."id" = ' + " #{num}" + '
          group by "operations"."id", "bills"."id", "date_operation_about_bill"
          having  "date_operation_about_bill" >  (SELECT add_months( CURRENT_DATE, -1 ) FROM DUAL);'
    render json: ActiveRecord::Base.connection.execute(sql)
  end

  def info_customer_with_max_sum
    sql = 'select "type_name", "first_name" from "customers"
          inner join "bills" on "customers"."id" = "bills"."customer_id"
          inner join "bill_types" on "bills"."type_id" = "bill_types"."id"
          group by "type_name","first_name";'
    render json: ActiveRecord::Base.connection.execute(sql)
  end

  def customer_with_every_bill_type
    sql = 'select DISTINCT "first_name", "type_name" from "customers"
          inner join "bills" on "customers"."id" = "bills"."customer_id"
          inner join "bill_types" on "bills"."type_id" = "bill_types"."id"
          where "type_name" in (select "type_name" from "bill_types" where "type_name" in ("deposite", "Stim" ));'
    render json: ActiveRecord::Base.connection.execute(sql)
  end

  def sum_for_every_customer
    sql = 'select "first_name", sum("balance_on_bill") from "customers"
          inner join "bills" on "customers"."id" = "bills"."customer_id"
          group by  "first_name";'
    render json: ActiveRecord::Base.connection.execute(sql)
  end

  def bill_statistic
    sql = 'select "type_name", "bill_num", "balance_on_bill", "date_creating_bill" from "bills"
          inner join "bill_types" on "bills"."type_id" = "bill_types"."id"
          group by "type_name", "bill_num", "balance_on_bill", "date_creating_bill";'
    render json: ActiveRecord::Base.connection.execute(sql)
  end

  def cost_moving_last_day
    sql =  'select * from "operations"
           where "date_operation_about_bill" >  (select sysdate - 1 from dual);'
    render json: ActiveRecord::Base.connection.execute(sql)
  end
end
