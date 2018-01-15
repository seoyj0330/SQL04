--문제 1번
-- 평균 급여보다 적은 월급을 받는 직원은 몇 명 ?      //56명
select employee_id, first_name, salary
from employees
where salary < (select avg(salary)
                from employees) ;
               
               
--문제 2번
--  부서별로 최고 급여를 받는 사원의 직원번호, 성, 급여, 부서번호를 조회
-- 단 조회결과는 급여의 내림차순 desc        //11명
select employee_id, last_name, salary, department_id
from employees
where (department_id, salary) in( select department_id, max(salary)
                                  from employees
                                  group by department_id) 
order by salary desc;   
                      
        
--문제 3번
--  각 업무 별로 연봉의 총합을 구하고자 한다. 
--  연봉 총합이 가장 높은 업무부터 업무명과 연봉총합을 조회하시오       //19부서
select jb.job_title, sum(salary)  
from employees em , (select job_id, job_title 
                     from jobs) jb
where jb.job_id = em.job_id
group by job_title
order by sum(salary) desc; 


--문제 4번
--  자신의 부서 평균 급여보다 연봉이 많은 직원의 직원번호, 성, 급여를 조회       //38명
select em.employee_id, em.last_name, em.salary
from employees em, 
    (select department_id, avg(salary) avgs
     from employees
     group by department_id) emp
where em.department_id = emp.department_id 
  and em.salary > emp.avgs; 
  --값만 가져오려고 별명?을 씀(avgs라고)
  --avg(salary)를 쓰면 함수라 또다시 계산할 수도 있기 때문에