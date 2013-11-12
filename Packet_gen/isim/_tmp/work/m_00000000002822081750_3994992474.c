/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2007 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

/* This file is designed for use with ISim build 0x9330dbfa */

#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/mtnguyen/ISEp_Packet_gen/Packet_gen/small_fifo_v3.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};
static int ng3[] = {1, 0};
static const char *ng4 = "";
static const char *ng5 = " ERROR: Attempt to write to full FIFO: %m";
static const char *ng6 = " ERROR: Attempt to read an empty FIFO: %m";



static void A46_0(char *t0)
{
    char t13[8];
    char t14[8];
    char t35[24];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    unsigned int t25;
    int t26;
    char *t27;
    unsigned int t28;
    int t29;
    int t30;
    unsigned int t31;
    unsigned int t32;
    int t33;
    int t34;

LAB0:    t1 = (t0 + 2628U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 3512);
    *((int *)t2) = 1;
    t3 = (t0 + 2652);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(47, ng0);

LAB5:    xsi_set_current_line(48, ng0);
    t4 = (t0 + 956U);
    t5 = *((char **)t4);
    t4 = (t5 + 4U);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:
LAB8:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 1044U);
    t3 = *((char **)t2);
    t2 = (t3 + 4U);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB11;

LAB12:
LAB13:    goto LAB2;

LAB6:    xsi_set_current_line(49, ng0);
    t11 = (t0 + 868U);
    t12 = *((char **)t11);
    t11 = (t0 + 1888);
    t15 = (t0 + 1888);
    t16 = (t15 + 40U);
    t17 = *((char **)t16);
    t18 = (t0 + 1888);
    t19 = (t18 + 36U);
    t20 = *((char **)t19);
    t21 = (t0 + 2072);
    t22 = (t21 + 32U);
    t23 = *((char **)t22);
    xsi_vlog_generic_convert_array_indices(t13, t14, t17, t20, 2, 1, t23, 2, 2);
    t24 = (t13 + 4U);
    t25 = *((unsigned int *)t24);
    t26 = (!(t25));
    t27 = (t14 + 4U);
    t28 = *((unsigned int *)t27);
    t29 = (!(t28));
    t30 = (t26 && t29);
    if (t30 == 1)
        goto LAB9;

LAB10:    goto LAB8;

LAB9:    t31 = *((unsigned int *)t13);
    t32 = *((unsigned int *)t14);
    t33 = (t31 - t32);
    t34 = (t33 + 1);
    xsi_vlogvar_generic_wait_assign_value(t11, t12, 2, 0, *((unsigned int *)t14), t34, 0LL);
    goto LAB10;

LAB11:    xsi_set_current_line(51, ng0);
    t4 = (t0 + 1888);
    t5 = (t4 + 32U);
    t11 = *((char **)t5);
    t12 = (t0 + 1888);
    t15 = (t12 + 40U);
    t16 = *((char **)t15);
    t17 = (t0 + 1888);
    t18 = (t17 + 36U);
    t19 = *((char **)t18);
    t20 = (t0 + 1980);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    xsi_vlog_generic_get_array_select_value(t35, 72, t11, t16, t19, 2, 1, t22, 2, 2);
    t23 = (t0 + 1796);
    xsi_vlogvar_generic_wait_assign_value(t23, t35, 2, 0, 0, 72, 1000000LL);
    goto LAB13;

}

static void A58_1(char *t0)
{
    char t13[8];
    char t18[8];
    char t57[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    char *t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    int t39;
    int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t58;

LAB0:    t1 = (t0 + 2748U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 3520);
    *((int *)t2) = 1;
    t3 = (t0 + 2772);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(59, ng0);

LAB5:    xsi_set_current_line(60, ng0);
    t4 = (t0 + 1484U);
    t5 = *((char **)t4);
    t4 = (t5 + 4U);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(65, ng0);

LAB10:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 956U);
    t3 = *((char **)t2);
    t2 = (t3 + 4U);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB11;

LAB12:
LAB13:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 1044U);
    t3 = *((char **)t2);
    t2 = (t3 + 4U);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB14;

LAB15:
LAB16:    xsi_set_current_line(68, ng0);
    t2 = (t0 + 956U);
    t3 = *((char **)t2);
    t2 = (t0 + 1044U);
    t4 = *((char **)t2);
    memset(t13, 0, 8);
    t2 = (t13 + 4U);
    t5 = (t4 + 4U);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    *((unsigned int *)t13) = t7;
    *((unsigned int *)t2) = 0;
    if (*((unsigned int *)t5) != 0)
        goto LAB18;

LAB17:    t16 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t16 & 1U);
    t17 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t17 & 1U);
    t19 = *((unsigned int *)t3);
    t20 = *((unsigned int *)t13);
    t21 = (t19 & t20);
    *((unsigned int *)t18) = t21;
    t11 = (t3 + 4U);
    t12 = (t13 + 4U);
    t14 = (t18 + 4U);
    t22 = *((unsigned int *)t11);
    t23 = *((unsigned int *)t12);
    t24 = (t22 | t23);
    *((unsigned int *)t14) = t24;
    t25 = *((unsigned int *)t14);
    t26 = (t25 != 0);
    if (t26 == 1)
        goto LAB19;

LAB20:
LAB21:    t47 = (t18 + 4U);
    t48 = *((unsigned int *)t47);
    t49 = (~(t48));
    t50 = *((unsigned int *)t18);
    t51 = (t50 & t49);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB22;

LAB23:    xsi_set_current_line(73, ng0);
    t2 = (t0 + 956U);
    t3 = *((char **)t2);
    memset(t13, 0, 8);
    t2 = (t13 + 4U);
    t4 = (t3 + 4U);
    t6 = *((unsigned int *)t3);
    t7 = (~(t6));
    *((unsigned int *)t13) = t7;
    *((unsigned int *)t2) = 0;
    if (*((unsigned int *)t4) != 0)
        goto LAB26;

LAB25:    t16 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t16 & 1U);
    t17 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t17 & 1U);
    t5 = (t0 + 1044U);
    t11 = *((char **)t5);
    t19 = *((unsigned int *)t13);
    t20 = *((unsigned int *)t11);
    t21 = (t19 & t20);
    *((unsigned int *)t18) = t21;
    t5 = (t13 + 4U);
    t12 = (t11 + 4U);
    t14 = (t18 + 4U);
    t22 = *((unsigned int *)t5);
    t23 = *((unsigned int *)t12);
    t24 = (t22 | t23);
    *((unsigned int *)t14) = t24;
    t25 = *((unsigned int *)t14);
    t26 = (t25 != 0);
    if (t26 == 1)
        goto LAB27;

LAB28:
LAB29:    t47 = (t18 + 4U);
    t48 = *((unsigned int *)t47);
    t49 = (~(t48));
    t50 = *((unsigned int *)t18);
    t51 = (t50 & t49);
    t52 = (t51 != 0);
    if (t52 > 0)
        goto LAB30;

LAB31:
LAB32:
LAB24:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(60, ng0);

LAB9:    xsi_set_current_line(61, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 1980);
    xsi_vlogvar_generic_wait_assign_value(t12, t11, 2, 0, 0, 2, 0LL);
    xsi_set_current_line(62, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2072);
    xsi_vlogvar_generic_wait_assign_value(t3, t2, 2, 0, 0, 2, 0LL);
    xsi_set_current_line(63, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2164);
    xsi_vlogvar_generic_wait_assign_value(t3, t2, 2, 0, 0, 3, 0LL);
    goto LAB8;

LAB11:    xsi_set_current_line(66, ng0);
    t4 = (t0 + 2072);
    t5 = (t4 + 32U);
    t11 = *((char **)t5);
    t12 = ((char*)((ng2)));
    memset(t13, 0, 8);
    xsi_vlog_unsigned_add(t13, 32, t11, 2, t12, 32);
    t14 = (t0 + 2072);
    xsi_vlogvar_generic_wait_assign_value(t14, t13, 2, 0, 0, 2, 0LL);
    goto LAB13;

LAB14:    xsi_set_current_line(67, ng0);
    t4 = (t0 + 1980);
    t5 = (t4 + 32U);
    t11 = *((char **)t5);
    t12 = ((char*)((ng2)));
    memset(t13, 0, 8);
    xsi_vlog_unsigned_add(t13, 32, t11, 2, t12, 32);
    t14 = (t0 + 1980);
    xsi_vlogvar_generic_wait_assign_value(t14, t13, 2, 0, 0, 2, 0LL);
    goto LAB16;

LAB18:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t5);
    *((unsigned int *)t13) = (t8 | t9);
    t10 = *((unsigned int *)t2);
    t15 = *((unsigned int *)t5);
    *((unsigned int *)t2) = (t10 | t15);
    goto LAB17;

LAB19:    t27 = *((unsigned int *)t18);
    t28 = *((unsigned int *)t14);
    *((unsigned int *)t18) = (t27 | t28);
    t29 = (t3 + 4U);
    t30 = (t13 + 4U);
    t31 = *((unsigned int *)t3);
    t32 = (~(t31));
    t33 = *((unsigned int *)t29);
    t34 = (~(t33));
    t35 = *((unsigned int *)t13);
    t36 = (~(t35));
    t37 = *((unsigned int *)t30);
    t38 = (~(t37));
    t39 = (t32 & t34);
    t40 = (t36 & t38);
    t41 = (~(t39));
    t42 = (~(t40));
    t43 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t43 & t41);
    t44 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t44 & t42);
    t45 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t45 & t41);
    t46 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t46 & t42);
    goto LAB21;

LAB22:    xsi_set_current_line(68, ng0);
    t53 = (t0 + 2164);
    t54 = (t53 + 32U);
    t55 = *((char **)t54);
    t56 = ((char*)((ng2)));
    memset(t57, 0, 8);
    xsi_vlog_unsigned_add(t57, 32, t55, 3, t56, 32);
    t58 = (t0 + 2164);
    xsi_vlogvar_generic_wait_assign_value(t58, t57, 2, 0, 0, 3, 1000000LL);
    goto LAB24;

LAB26:    t8 = *((unsigned int *)t13);
    t9 = *((unsigned int *)t4);
    *((unsigned int *)t13) = (t8 | t9);
    t10 = *((unsigned int *)t2);
    t15 = *((unsigned int *)t4);
    *((unsigned int *)t2) = (t10 | t15);
    goto LAB25;

LAB27:    t27 = *((unsigned int *)t18);
    t28 = *((unsigned int *)t14);
    *((unsigned int *)t18) = (t27 | t28);
    t29 = (t13 + 4U);
    t30 = (t11 + 4U);
    t31 = *((unsigned int *)t13);
    t32 = (~(t31));
    t33 = *((unsigned int *)t29);
    t34 = (~(t33));
    t35 = *((unsigned int *)t11);
    t36 = (~(t35));
    t37 = *((unsigned int *)t30);
    t38 = (~(t37));
    t39 = (t32 & t34);
    t40 = (t36 & t38);
    t41 = (~(t39));
    t42 = (~(t40));
    t43 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t43 & t41);
    t44 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t44 & t42);
    t45 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t45 & t41);
    t46 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t46 & t42);
    goto LAB29;

LAB30:    xsi_set_current_line(73, ng0);
    t53 = (t0 + 2164);
    t54 = (t53 + 32U);
    t55 = *((char **)t54);
    t56 = ((char*)((ng2)));
    memset(t57, 0, 8);
    xsi_vlog_unsigned_minus(t57, 32, t55, 3, t56, 32);
    t58 = (t0 + 2164);
    xsi_vlogvar_generic_wait_assign_value(t58, t57, 2, 0, 0, 3, 1000000LL);
    goto LAB32;

}

static void C82_2(char *t0)
{
    char t7[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;

LAB0:    t1 = (t0 + 2868U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2164);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t0 + 476);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    t5 = (t7 + 4U);
    t8 = (t4 + 4U);
    t9 = (t6 + 4U);
    t10 = *((unsigned int *)t4);
    t11 = *((unsigned int *)t6);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t9);
    t15 = (t13 ^ t14);
    t16 = (t12 | t15);
    t17 = *((unsigned int *)t8);
    t18 = *((unsigned int *)t9);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB7;

LAB4:    if (t19 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t7) = 1;

LAB7:    t22 = (t0 + 3604);
    t23 = (t22 + 32U);
    t24 = *((char **)t23);
    t25 = (t24 + 32U);
    t26 = *((char **)t25);
    t27 = (t26 + 4U);
    t28 = 1U;
    t29 = t28;
    t30 = (t7 + 4U);
    t31 = *((unsigned int *)t7);
    t28 = (t28 & t31);
    t32 = *((unsigned int *)t30);
    t29 = (t29 & t32);
    t33 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t33 & 4294967294U);
    t34 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t34 | t28);
    t35 = *((unsigned int *)t27);
    *((unsigned int *)t27) = (t35 & 4294967294U);
    t36 = *((unsigned int *)t27);
    *((unsigned int *)t27) = (t36 | t29);
    xsi_driver_vfirst_trans(t22, 0, 0);
    t37 = (t0 + 3528);
    *((int *)t37) = 1;

LAB1:    return;
LAB6:    *((unsigned int *)t7) = 1;
    *((unsigned int *)t5) = 1;
    goto LAB7;

}

static void C83_3(char *t0)
{
    char t7[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;

LAB0:    t1 = (t0 + 2988U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2164);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t0 + 400);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    t5 = (t7 + 4U);
    t8 = (t4 + 4U);
    t9 = (t6 + 4U);
    if (*((unsigned int *)t8) != 0)
        goto LAB5;

LAB4:    if (*((unsigned int *)t9) != 0)
        goto LAB5;

LAB8:    if (*((unsigned int *)t4) < *((unsigned int *)t6))
        goto LAB7;

LAB6:    *((unsigned int *)t7) = 1;

LAB7:    t10 = (t0 + 3640);
    t11 = (t10 + 32U);
    t12 = *((char **)t11);
    t13 = (t12 + 32U);
    t14 = *((char **)t13);
    t15 = (t14 + 4U);
    t16 = 1U;
    t17 = t16;
    t18 = (t7 + 4U);
    t19 = *((unsigned int *)t7);
    t16 = (t16 & t19);
    t20 = *((unsigned int *)t18);
    t17 = (t17 & t20);
    t21 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t21 & 4294967294U);
    t22 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t22 | t16);
    t23 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t23 & 4294967294U);
    t24 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t24 | t17);
    xsi_driver_vfirst_trans(t10, 0, 0);
    t25 = (t0 + 3536);
    *((int *)t25) = 1;

LAB1:    return;
LAB5:    *((unsigned int *)t7) = 1;
    *((unsigned int *)t5) = 1;
    goto LAB7;

}

static void C84_4(char *t0)
{
    char t7[8];
    char t8[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;

LAB0:    t1 = (t0 + 3108U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2164);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t0 + 476);
    t6 = *((char **)t5);
    t5 = ((char*)((ng3)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_minus(t7, 32, t6, 32, t5, 32);
    memset(t8, 0, 8);
    t9 = (t8 + 4U);
    t10 = (t4 + 4U);
    t11 = (t7 + 4U);
    if (*((unsigned int *)t10) != 0)
        goto LAB5;

LAB4:    if (*((unsigned int *)t11) != 0)
        goto LAB5;

LAB8:    if (*((unsigned int *)t4) < *((unsigned int *)t7))
        goto LAB7;

LAB6:    *((unsigned int *)t8) = 1;

LAB7:    t12 = (t0 + 3676);
    t13 = (t12 + 32U);
    t14 = *((char **)t13);
    t15 = (t14 + 32U);
    t16 = *((char **)t15);
    t17 = (t16 + 4U);
    t18 = 1U;
    t19 = t18;
    t20 = (t8 + 4U);
    t21 = *((unsigned int *)t8);
    t18 = (t18 & t21);
    t22 = *((unsigned int *)t20);
    t19 = (t19 & t22);
    t23 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t23 & 4294967294U);
    t24 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t24 | t18);
    t25 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t25 & 4294967294U);
    t26 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t26 | t19);
    xsi_driver_vfirst_trans(t12, 0, 0);
    t27 = (t0 + 3544);
    *((int *)t27) = 1;

LAB1:    return;
LAB5:    *((unsigned int *)t8) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB7;

}

static void C85_5(char *t0)
{
    char t6[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;

LAB0:    t1 = (t0 + 3228U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2164);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t7 = (t6 + 4U);
    t8 = (t4 + 4U);
    t9 = (t5 + 4U);
    t10 = *((unsigned int *)t4);
    t11 = *((unsigned int *)t5);
    t12 = (t10 ^ t11);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t9);
    t15 = (t13 ^ t14);
    t16 = (t12 | t15);
    t17 = *((unsigned int *)t8);
    t18 = *((unsigned int *)t9);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB7;

LAB4:    if (t19 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t6) = 1;

LAB7:    t22 = (t0 + 3712);
    t23 = (t22 + 32U);
    t24 = *((char **)t23);
    t25 = (t24 + 32U);
    t26 = *((char **)t25);
    t27 = (t26 + 4U);
    t28 = 1U;
    t29 = t28;
    t30 = (t6 + 4U);
    t31 = *((unsigned int *)t6);
    t28 = (t28 & t31);
    t32 = *((unsigned int *)t30);
    t29 = (t29 & t32);
    t33 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t33 & 4294967294U);
    t34 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t34 | t28);
    t35 = *((unsigned int *)t27);
    *((unsigned int *)t27) = (t35 & 4294967294U);
    t36 = *((unsigned int *)t27);
    *((unsigned int *)t27) = (t36 | t29);
    xsi_driver_vfirst_trans(t22, 0, 0);
    t37 = (t0 + 3552);
    *((int *)t37) = 1;

LAB1:    return;
LAB6:    *((unsigned int *)t6) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB7;

}

static void A88_6(char *t0)
{
    char t6[8];
    char t22[8];
    char t37[8];
    char t45[8];
    char t77[8];
    char t89[8];
    char t98[8];
    char t106[8];
    char t144[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    char *t49;
    char *t50;
    char *t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t59;
    char *t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    int t69;
    int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    char *t78;
    char *t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    char *t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    char *t90;
    char *t91;
    char *t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    char *t99;
    char *t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    char *t110;
    char *t111;
    char *t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    unsigned int t118;
    unsigned int t119;
    char *t120;
    char *t121;
    unsigned int t122;
    unsigned int t123;
    unsigned int t124;
    unsigned int t125;
    unsigned int t126;
    unsigned int t127;
    unsigned int t128;
    unsigned int t129;
    int t130;
    int t131;
    unsigned int t132;
    unsigned int t133;
    unsigned int t134;
    unsigned int t135;
    unsigned int t136;
    unsigned int t137;
    char *t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    unsigned int t143;
    char *t145;

LAB0:    t1 = (t0 + 3348U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(88, ng0);
    t2 = (t0 + 3560);
    *((int *)t2) = 1;
    t3 = (t0 + 3372);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(89, ng0);

LAB5:    xsi_set_current_line(90, ng0);
    t4 = (t0 + 956U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t4 = (t6 + 4U);
    t7 = (t5 + 4U);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t5);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB6;

LAB7:    if (*((unsigned int *)t7) != 0)
        goto LAB8;

LAB9:    t13 = (t6 + 4U);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t13);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB10;

LAB11:    memcpy(t45, t6, 8);

LAB12:    memset(t77, 0, 8);
    t78 = (t77 + 4U);
    t79 = (t45 + 4U);
    t80 = *((unsigned int *)t79);
    t81 = (~(t80));
    t82 = *((unsigned int *)t45);
    t83 = (t82 & t81);
    t84 = (t83 & 1U);
    if (t84 != 0)
        goto LAB24;

LAB25:    if (*((unsigned int *)t79) != 0)
        goto LAB26;

LAB27:    t85 = (t77 + 4U);
    t86 = *((unsigned int *)t77);
    t87 = *((unsigned int *)t85);
    t88 = (t86 || t87);
    if (t88 > 0)
        goto LAB28;

LAB29:    memcpy(t106, t77, 8);

LAB30:    t138 = (t106 + 4U);
    t139 = *((unsigned int *)t138);
    t140 = (~(t139));
    t141 = *((unsigned int *)t106);
    t142 = (t141 & t140);
    t143 = (t142 != 0);
    if (t143 > 0)
        goto LAB42;

LAB43:
LAB44:    xsi_set_current_line(92, ng0);
    t2 = (t0 + 1044U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t6 + 4U);
    t4 = (t3 + 4U);
    t8 = *((unsigned int *)t4);
    t9 = (~(t8));
    t10 = *((unsigned int *)t3);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB45;

LAB46:    if (*((unsigned int *)t4) != 0)
        goto LAB47;

LAB48:    t5 = (t6 + 4U);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t5);
    t16 = (t14 || t15);
    if (t16 > 0)
        goto LAB49;

LAB50:    memcpy(t45, t6, 8);

LAB51:    t59 = (t45 + 4U);
    t80 = *((unsigned int *)t59);
    t81 = (~(t80));
    t82 = *((unsigned int *)t45);
    t83 = (t82 & t81);
    t84 = (t83 != 0);
    if (t84 > 0)
        goto LAB63;

LAB64:
LAB65:    goto LAB2;

LAB6:    *((unsigned int *)t6) = 1;
    goto LAB9;

LAB8:    *((unsigned int *)t6) = 1;
    *((unsigned int *)t4) = 1;
    goto LAB9;

LAB10:    t17 = (t0 + 2164);
    t18 = (t17 + 32U);
    t19 = *((char **)t18);
    t20 = (t0 + 476);
    t21 = *((char **)t20);
    memset(t22, 0, 8);
    t20 = (t22 + 4U);
    t23 = (t19 + 4U);
    t24 = (t21 + 4U);
    t25 = *((unsigned int *)t19);
    t26 = *((unsigned int *)t21);
    t27 = (t25 ^ t26);
    t28 = *((unsigned int *)t23);
    t29 = *((unsigned int *)t24);
    t30 = (t28 ^ t29);
    t31 = (t27 | t30);
    t32 = *((unsigned int *)t23);
    t33 = *((unsigned int *)t24);
    t34 = (t32 | t33);
    t35 = (~(t34));
    t36 = (t31 & t35);
    if (t36 != 0)
        goto LAB16;

LAB13:    if (t34 != 0)
        goto LAB15;

LAB14:    *((unsigned int *)t22) = 1;

LAB16:    memset(t37, 0, 8);
    t38 = (t37 + 4U);
    t39 = (t22 + 4U);
    t40 = *((unsigned int *)t39);
    t41 = (~(t40));
    t42 = *((unsigned int *)t22);
    t43 = (t42 & t41);
    t44 = (t43 & 1U);
    if (t44 != 0)
        goto LAB17;

LAB18:    if (*((unsigned int *)t39) != 0)
        goto LAB19;

LAB20:    t46 = *((unsigned int *)t6);
    t47 = *((unsigned int *)t37);
    t48 = (t46 & t47);
    *((unsigned int *)t45) = t48;
    t49 = (t6 + 4U);
    t50 = (t37 + 4U);
    t51 = (t45 + 4U);
    t52 = *((unsigned int *)t49);
    t53 = *((unsigned int *)t50);
    t54 = (t52 | t53);
    *((unsigned int *)t51) = t54;
    t55 = *((unsigned int *)t51);
    t56 = (t55 != 0);
    if (t56 == 1)
        goto LAB21;

LAB22:
LAB23:    goto LAB12;

LAB15:    *((unsigned int *)t22) = 1;
    *((unsigned int *)t20) = 1;
    goto LAB16;

LAB17:    *((unsigned int *)t37) = 1;
    goto LAB20;

LAB19:    *((unsigned int *)t37) = 1;
    *((unsigned int *)t38) = 1;
    goto LAB20;

LAB21:    t57 = *((unsigned int *)t45);
    t58 = *((unsigned int *)t51);
    *((unsigned int *)t45) = (t57 | t58);
    t59 = (t6 + 4U);
    t60 = (t37 + 4U);
    t61 = *((unsigned int *)t6);
    t62 = (~(t61));
    t63 = *((unsigned int *)t59);
    t64 = (~(t63));
    t65 = *((unsigned int *)t37);
    t66 = (~(t65));
    t67 = *((unsigned int *)t60);
    t68 = (~(t67));
    t69 = (t62 & t64);
    t70 = (t66 & t68);
    t71 = (~(t69));
    t72 = (~(t70));
    t73 = *((unsigned int *)t51);
    *((unsigned int *)t51) = (t73 & t71);
    t74 = *((unsigned int *)t51);
    *((unsigned int *)t51) = (t74 & t72);
    t75 = *((unsigned int *)t45);
    *((unsigned int *)t45) = (t75 & t71);
    t76 = *((unsigned int *)t45);
    *((unsigned int *)t45) = (t76 & t72);
    goto LAB23;

LAB24:    *((unsigned int *)t77) = 1;
    goto LAB27;

LAB26:    *((unsigned int *)t77) = 1;
    *((unsigned int *)t78) = 1;
    goto LAB27;

LAB28:    t90 = (t0 + 1044U);
    t91 = *((char **)t90);
    memset(t89, 0, 8);
    t90 = (t89 + 4U);
    t92 = (t91 + 4U);
    t93 = *((unsigned int *)t92);
    t94 = (~(t93));
    t95 = *((unsigned int *)t91);
    t96 = (t95 & t94);
    t97 = (t96 & 1U);
    if (t97 != 0)
        goto LAB34;

LAB32:    if (*((unsigned int *)t92) == 0)
        goto LAB31;

LAB33:    *((unsigned int *)t89) = 1;
    *((unsigned int *)t90) = 1;

LAB34:    memset(t98, 0, 8);
    t99 = (t98 + 4U);
    t100 = (t89 + 4U);
    t101 = *((unsigned int *)t100);
    t102 = (~(t101));
    t103 = *((unsigned int *)t89);
    t104 = (t103 & t102);
    t105 = (t104 & 1U);
    if (t105 != 0)
        goto LAB35;

LAB36:    if (*((unsigned int *)t100) != 0)
        goto LAB37;

LAB38:    t107 = *((unsigned int *)t77);
    t108 = *((unsigned int *)t98);
    t109 = (t107 & t108);
    *((unsigned int *)t106) = t109;
    t110 = (t77 + 4U);
    t111 = (t98 + 4U);
    t112 = (t106 + 4U);
    t113 = *((unsigned int *)t110);
    t114 = *((unsigned int *)t111);
    t115 = (t113 | t114);
    *((unsigned int *)t112) = t115;
    t116 = *((unsigned int *)t112);
    t117 = (t116 != 0);
    if (t117 == 1)
        goto LAB39;

LAB40:
LAB41:    goto LAB30;

LAB31:    *((unsigned int *)t89) = 1;
    goto LAB34;

LAB35:    *((unsigned int *)t98) = 1;
    goto LAB38;

LAB37:    *((unsigned int *)t98) = 1;
    *((unsigned int *)t99) = 1;
    goto LAB38;

LAB39:    t118 = *((unsigned int *)t106);
    t119 = *((unsigned int *)t112);
    *((unsigned int *)t106) = (t118 | t119);
    t120 = (t77 + 4U);
    t121 = (t98 + 4U);
    t122 = *((unsigned int *)t77);
    t123 = (~(t122));
    t124 = *((unsigned int *)t120);
    t125 = (~(t124));
    t126 = *((unsigned int *)t98);
    t127 = (~(t126));
    t128 = *((unsigned int *)t121);
    t129 = (~(t128));
    t130 = (t123 & t125);
    t131 = (t127 & t129);
    t132 = (~(t130));
    t133 = (~(t131));
    t134 = *((unsigned int *)t112);
    *((unsigned int *)t112) = (t134 & t132);
    t135 = *((unsigned int *)t112);
    *((unsigned int *)t112) = (t135 & t133);
    t136 = *((unsigned int *)t106);
    *((unsigned int *)t106) = (t136 & t132);
    t137 = *((unsigned int *)t106);
    *((unsigned int *)t106) = (t137 & t133);
    goto LAB41;

LAB42:    xsi_set_current_line(91, ng0);
    t145 = xsi_vlog_time(t144, 1000000.000000000, 1000.000000000000);
    xsi_vlogfile_write(0, 0, ng4, 2, t0, (char)118, t144, 64);
    xsi_vlogfile_write(1, 0, ng5, 1, t0);
    goto LAB44;

LAB45:    *((unsigned int *)t6) = 1;
    goto LAB48;

LAB47:    *((unsigned int *)t6) = 1;
    *((unsigned int *)t2) = 1;
    goto LAB48;

LAB49:    t7 = (t0 + 2164);
    t13 = (t7 + 32U);
    t17 = *((char **)t13);
    t18 = ((char*)((ng1)));
    memset(t22, 0, 8);
    t19 = (t22 + 4U);
    t20 = (t17 + 4U);
    t21 = (t18 + 4U);
    t25 = *((unsigned int *)t17);
    t26 = *((unsigned int *)t18);
    t27 = (t25 ^ t26);
    t28 = *((unsigned int *)t20);
    t29 = *((unsigned int *)t21);
    t30 = (t28 ^ t29);
    t31 = (t27 | t30);
    t32 = *((unsigned int *)t20);
    t33 = *((unsigned int *)t21);
    t34 = (t32 | t33);
    t35 = (~(t34));
    t36 = (t31 & t35);
    if (t36 != 0)
        goto LAB55;

LAB52:    if (t34 != 0)
        goto LAB54;

LAB53:    *((unsigned int *)t22) = 1;

LAB55:    memset(t37, 0, 8);
    t23 = (t37 + 4U);
    t24 = (t22 + 4U);
    t40 = *((unsigned int *)t24);
    t41 = (~(t40));
    t42 = *((unsigned int *)t22);
    t43 = (t42 & t41);
    t44 = (t43 & 1U);
    if (t44 != 0)
        goto LAB56;

LAB57:    if (*((unsigned int *)t24) != 0)
        goto LAB58;

LAB59:    t46 = *((unsigned int *)t6);
    t47 = *((unsigned int *)t37);
    t48 = (t46 & t47);
    *((unsigned int *)t45) = t48;
    t38 = (t6 + 4U);
    t39 = (t37 + 4U);
    t49 = (t45 + 4U);
    t52 = *((unsigned int *)t38);
    t53 = *((unsigned int *)t39);
    t54 = (t52 | t53);
    *((unsigned int *)t49) = t54;
    t55 = *((unsigned int *)t49);
    t56 = (t55 != 0);
    if (t56 == 1)
        goto LAB60;

LAB61:
LAB62:    goto LAB51;

LAB54:    *((unsigned int *)t22) = 1;
    *((unsigned int *)t19) = 1;
    goto LAB55;

LAB56:    *((unsigned int *)t37) = 1;
    goto LAB59;

LAB58:    *((unsigned int *)t37) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB59;

LAB60:    t57 = *((unsigned int *)t45);
    t58 = *((unsigned int *)t49);
    *((unsigned int *)t45) = (t57 | t58);
    t50 = (t6 + 4U);
    t51 = (t37 + 4U);
    t61 = *((unsigned int *)t6);
    t62 = (~(t61));
    t63 = *((unsigned int *)t50);
    t64 = (~(t63));
    t65 = *((unsigned int *)t37);
    t66 = (~(t65));
    t67 = *((unsigned int *)t51);
    t68 = (~(t67));
    t69 = (t62 & t64);
    t70 = (t66 & t68);
    t71 = (~(t69));
    t72 = (~(t70));
    t73 = *((unsigned int *)t49);
    *((unsigned int *)t49) = (t73 & t71);
    t74 = *((unsigned int *)t49);
    *((unsigned int *)t49) = (t74 & t72);
    t75 = *((unsigned int *)t45);
    *((unsigned int *)t45) = (t75 & t71);
    t76 = *((unsigned int *)t45);
    *((unsigned int *)t45) = (t76 & t72);
    goto LAB62;

LAB63:    xsi_set_current_line(93, ng0);
    t60 = xsi_vlog_time(t144, 1000000.000000000, 1000.000000000000);
    xsi_vlogfile_write(0, 0, ng4, 2, t0, (char)118, t144, 64);
    xsi_vlogfile_write(1, 0, ng6, 1, t0);
    goto LAB65;

}


extern void work_m_00000000002822081750_3994992474_init()
{
	static char *pe[] = {(void *)A46_0,(void *)A58_1,(void *)C82_2,(void *)C83_3,(void *)C84_4,(void *)C85_5,(void *)A88_6};
	xsi_register_didat("work_m_00000000002822081750_3994992474", "isim/_tmp/work/m_00000000002822081750_3994992474.didat");
	xsi_register_executes(pe);
}
