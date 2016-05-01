### Periodic Life Table (Belgium)

## Gompertz and Makeham's legal minimal mortality tables

# Insurance type 'survival'
mr_k <- 1000266.63
mr_s <- 0.999441703848
mr_g <- 0.999733441115
mr_c <- 1.101077536030

fr_k <- 1000048.56
fr_s <- 0.999669730966
fr_g <- 0.999951440172
fr_c <- 1.116792453830

# Insurance type 'death'
mk_k <- 1000450.59
mk_s <- 0.999106875782
mk_g <- 0.999549614043
mk_c <- 1.103798111448

fk_k <- 1000097.39
fk_s <- 0.999257048061
fk_g <- 0.999902624311
fk_c <- 1.118239062025

# Gompertz and Makeham's formula: Number of survivors at age X
survivor <- function(age, sex, insurance_type){
        if (insurance_type == "death"){
                if (sex == "m"){
                        survivor = mk_k * mk_s^age * mk_g^(mk_c^age)
                }
                if (sex == "f"){
                        survivor = fk_k * fk_s^age * fk_g^(fk_c^age)
                }
        }
        if (insurance_type == "survival"){
                if (sex == "m"){
                        survivor = mr_k * mr_s^age * mr_g^(mr_c^age)
                }
                if (sex == "f"){
                        survivor = fr_k * fr_s^age * fr_g^(fr_c^age)
                }
        }
        if (age >= 120){
                survivor = 0
        }
        survivor = round(survivor, 0)
        return(survivor)
}

## Number of deaths at age X

death <- function(age, sex, insurance_type){
        l_x = survivor(age, sex, insurance_type)
        l_x1 = survivor(age + 1, sex, insurance_type)
        death = l_x - l_x1
        death = round(death, 0)
        return(death)
}

## Probability of death over one year

proba_death_1 <- function(age, sex, insurance_type){
        d_x = death(age, sex, insurance_type)
        l_x = survivor(age, sex, insurance_type)
        if (l_x == 0){
                proba_death_1 = 1
        } else {
                proba_death_1 = d_x / l_x
        }
        return(proba_death_1)
}

## Probability of death over N years

proba_death_n <- function(age, N, sex, insurance_type){
        l_x = survivor(age, sex, insurance_type)
        l_xn = survivor(age + N, sex, insurance_type)
        if (l_x == 0){
                proba_death_n = 1
        } else {
                proba_death_n = (l_x - l_xn) / l_x
        }
        return(proba_death_n)
}

## Probability of death over one year in N years

proba_death_n1 <- function(age, N, sex, insurance_type){
        l_xn = survivor(age + N, sex, insurance_type)
        l_xn1 = survivor(age + N + 1, sex, insurance_type)
        l_x = survivor(age, sex, insurance_type)
        if ((l_x == 0) | (l_xn == 0)){
                proba_death_n1 = 1
        } else {
                proba_death_n1 = (l_xn - l_xn1) / l_x
        }
        return(proba_death_n1)
}

## Probability of survival over one year

proba_survi_1 <- function(age, sex, insurance_type){
        l_x1 = survivor(age + 1, sex, insurance_type)
        l_x = survivor(age, sex, insurance_type)
        proba_survi_1 = l_x1 / l_x
        return(proba_survi_1)
}

## Probability of survival over N years

proba_survi_n <- function(age, N, sex, insurance_type){
        l_xn = survivor(age + N, sex, insurance_type)
        l_x = survivor(age, sex, insurance_type)
        if (l_x == 0){
                proba_survi_n = 0
        } else {
                proba_survi_n = l_xn / l_x
        }
        return(proba_survi_n)
}

## Complete life expectancy

life_expect <- function(age, sex, insurance_type){
        life_expect <- 0
        for (i in 1:(120 - age)){
                t = i
                t1_q_x = proba_death_n1(age, t, sex, insurance_type)
                if (t1_q_x == 1){t1_q_x = 0}
                life_expect = life_expect + t * t1_q_x
        }
        if (round(life_expect, 0) < 1){
                life_expect = life_expect
        } else {
                life_expect = life_expect + 0.5 
        }
        life_expect = round(life_expect, 2)
        return(life_expect)
}
