--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-20 18:55:14 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16403)
-- Name: exercise_categories; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.exercise_categories (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.exercise_categories OWNER TO docker;

--
-- TOC entry 217 (class 1259 OID 16402)
-- Name: exercise_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.exercise_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercise_categories_id_seq OWNER TO docker;

--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 217
-- Name: exercise_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.exercise_categories_id_seq OWNED BY public.exercise_categories.id;


--
-- TOC entry 221 (class 1259 OID 16429)
-- Name: exercises; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.exercises (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    category_id integer NOT NULL,
    description text,
    video_url character varying(256),
    creator_id integer,
    is_private boolean DEFAULT false NOT NULL,
    image_url character varying(256)
);


ALTER TABLE public.exercises OWNER TO docker;

--
-- TOC entry 222 (class 1259 OID 16443)
-- Name: exercises_creator_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.exercises_creator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercises_creator_id_seq OWNER TO docker;

--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 222
-- Name: exercises_creator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.exercises_creator_id_seq OWNED BY public.exercises.creator_id;


--
-- TOC entry 220 (class 1259 OID 16428)
-- Name: private_exercises_category_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.private_exercises_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.private_exercises_category_id_seq OWNER TO docker;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 220
-- Name: private_exercises_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.private_exercises_category_id_seq OWNED BY public.exercises.category_id;


--
-- TOC entry 219 (class 1259 OID 16427)
-- Name: private_exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.private_exercises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.private_exercises_id_seq OWNER TO docker;

--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 219
-- Name: private_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.private_exercises_id_seq OWNED BY public.exercises.id;


--
-- TOC entry 216 (class 1259 OID 16390)
-- Name: users; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(64) NOT NULL,
    last_name character varying(64) NOT NULL,
    email character varying(128) NOT NULL,
    password character varying(256) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    is_admin boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO docker;

--
-- TOC entry 215 (class 1259 OID 16389)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO docker;

--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 226 (class 1259 OID 16461)
-- Name: workouts; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.workouts (
    id integer NOT NULL,
    exercise_id integer NOT NULL,
    user_id integer NOT NULL,
    date date NOT NULL,
    sets bigint NOT NULL,
    reps bigint NOT NULL,
    weight numeric NOT NULL
);


ALTER TABLE public.workouts OWNER TO docker;

--
-- TOC entry 224 (class 1259 OID 16459)
-- Name: workouts_exercise_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.workouts_exercise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workouts_exercise_id_seq OWNER TO docker;

--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 224
-- Name: workouts_exercise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workouts_exercise_id_seq OWNED BY public.workouts.exercise_id;


--
-- TOC entry 223 (class 1259 OID 16458)
-- Name: workouts_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.workouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workouts_id_seq OWNER TO docker;

--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 223
-- Name: workouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workouts_id_seq OWNED BY public.workouts.id;


--
-- TOC entry 225 (class 1259 OID 16460)
-- Name: workouts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.workouts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workouts_user_id_seq OWNER TO docker;

--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 225
-- Name: workouts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workouts_user_id_seq OWNED BY public.workouts.user_id;


--
-- TOC entry 3225 (class 2604 OID 16406)
-- Name: exercise_categories id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercise_categories ALTER COLUMN id SET DEFAULT nextval('public.exercise_categories_id_seq'::regclass);


--
-- TOC entry 3226 (class 2604 OID 16432)
-- Name: exercises id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises ALTER COLUMN id SET DEFAULT nextval('public.private_exercises_id_seq'::regclass);


--
-- TOC entry 3227 (class 2604 OID 16433)
-- Name: exercises category_id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises ALTER COLUMN category_id SET DEFAULT nextval('public.private_exercises_category_id_seq'::regclass);


--
-- TOC entry 3222 (class 2604 OID 16393)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 16464)
-- Name: workouts id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workouts ALTER COLUMN id SET DEFAULT nextval('public.workouts_id_seq'::regclass);


--
-- TOC entry 3393 (class 0 OID 16403)
-- Dependencies: 218
-- Data for Name: exercise_categories; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.exercise_categories (id, name) FROM stdin;
1	Legs
2	Triceps
3	Biceps
4	Back
5	Chest
\.


--
-- TOC entry 3396 (class 0 OID 16429)
-- Dependencies: 221
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.exercises (id, name, category_id, description, video_url, creator_id, is_private, image_url) FROM stdin;
10	T-Bar Row	4	Compound exercise for mid to upper back development.	https://www.youtube.com/watch?v=yPis7nlbqdY	\N	f	https://images.ctfassets.net/8urtyqugdt2l/5pziwWANOaPjQS2caLU8vd/83764919b6f35d9b053dd33bcb591fc9/t-bar-row-thumbnail.jpg
2	Pec Deck Machine	5	Isolates the chest muscles with controlled movement.	https://www.youtube.com/watch?v=O-OBCfyh9Fw	\N	f	https://workouthealthy.com/cdn/shop/files/BS-DPEC-SF_Body-Solid-Pec-Deck-Rear-Delt-Fly-Machine.webp?v=1699486491
3	Dips	5	Emphasizes the lower chest and triceps when leaning forward.	https://www.youtube.com/watch?v=o2qX3Zb5mvg	\N	f	https://hips.hearstapps.com/hmg-prod/images/dips-1608221119.jpg?resize=980:*
4	Chest Flys	5	Can be done with dumbbells or a cable machine to enhance chest width and depth.	https://www.youtube.com/watch?v=eozdVDA78K0	\N	f	https://www.garagegymreviews.com/wp-content/uploads/woman-doing-an-incline-chest-fly.jpg
5	Incline Dumbbell Press	5	\N	https://www.youtube.com/watch?v=8iPEnn-ltC8	\N	f	https://www.dmoose.com/cdn/shop/articles/1_8a79831d-72ad-4d42-aca0-9bc7580f575b.jpg?v=1648826825
6	Push-ups	5	Versatile bodyweight exercise that targets the chest along with other upper body muscles.	https://www.youtube.com/watch?v=IODxDxX7oi4	\N	f	https://cdn.mos.cms.futurecdn.net/oYDbf5hQAePHEBNZTQMXRA.jpg
7	Bench Press	5	Standard exercise using a barbell to build the pectoral muscles.	https://www.youtube.com/watch?v=rT7DgCr-3pg	\N	f	https://www.trainheroic.com/wp-content/uploads/2021/09/Bench-press.jpg
8	Back Extensions	4	Strengthen the lower back muscles.	https://www.youtube.com/watch?v=5_ejbGfdAQE	\N	f	https://hips.hearstapps.com/hmg-prod/images/screen-shot-2022-11-11-at-9-49-18-am-1668183899.png
9	Face Pulls	4	Improve rear deltoids and upper back muscles.	https://www.youtube.com/watch?v=0Po47vvj9g4	\N	f	https://www.garagegymreviews.com/wp-content/uploads/woman-performing-cable-face-pull.jpg
11	Lat Pulldowns	4	\N	https://www.youtube.com/watch?v=JGeRYIZdojU	\N	f	https://miro.medium.com/v2/resize:fit:1358/0*7g3xHWvaXcGhd2Ag.jpg
12	Bent-over Rows	4	Great for horizontal pulling strength, targeting mid-back.	https://www.youtube.com/watch?v=6FZHJGzMFEc	\N	f	https://hips.hearstapps.com/hmg-prod/images/joshua-simpson-kettlebell-vs-dumbbell-kb-bent-over-alternating-row-219-1636665510.jpg?crop=0.529xw:0.767xh;0.288xw,0.198xh&resize=1200:*
13	Deadlifts	4	\N	https://www.youtube.com/watch?v=AweC3UaM14o	\N	f	https://experiencelife.lifetime.life/wp-content/uploads/2021/08/f2-barbell-deadlift.jpg
14	Pull-ups	4	Strengthen the entire back and biceps with bodyweight.	https://www.youtube.com/watch?v=aAggnpPyR6E	\N	f	https://i0.wp.com/post.healthline.com/wp-content/uploads/2019/12/pull-up-pullup-gym-1296x728-header-1296x728.jpg?w=1155&h=1528
15	Chin-ups	3	Also works the biceps along with the back.	https://www.youtube.com/watch?v=8mryJ3w2S78	\N	f	https://media.self.com/photos/5bad13813f15b979ec0368eb/master/pass/woman-doing-chin-up.jpg
16	Cable Curl	3	Provides constant tension through the motion.	https://www.youtube.com/watch?v=opFVuRi_3b8	\N	f	https://origympersonaltrainercourses.co.uk/files/img_cache/9418/1920_1603357692_bicepcablecurl.JPG?1603357910
17	Peacher Curl	3	Stabilizes the arm, increasing isolation during the curl.	https://www.youtube.com/watch?v=Ja6ZlIDONac	\N	f	https://prod-ne-cdn-media.puregym.com/media/819541/preacher-curls.png?quality=80
18	Concentration Curl	3	Isolates one bicep at a time for focused tension.	https://www.youtube.com/watch?v=VMbDQ8PZazY	\N	f	https://cdn.muscleandstrength.com/sites/default/files/seated-concentration-curl.jpg
19	Hammer Curl	3	Targets the biceps and brachialis with a neutral grip.	https://www.youtube.com/watch?v=RIEMoYL_h1Y	\N	f	https://www.trainheroic.com/wp-content/uploads/2023/02/AdobeStock_417412809-TH-jpg.webp
20	Barbell Curl	3	Classic exercise for bicep growth.	https://www.youtube.com/watch?v=JnLFSFurrqQ	\N	f	https://mirafit.co.uk/wp/wp-content/uploads/2019/08/fitness-expert-doing-bicep-curls-with-an-ez-cutl-bar-1024x683.jpg
21	Diamond Push-ups	2	Bodyweight exercise focusing on the triceps and chest.	https://www.youtube.com/watch?v=XtU2VQVuLYs	\N	f	https://res.cloudinary.com/peloton-cycle/image/fetch/f_auto,c_limit,w_3840,q_90/https://images.ctfassets.net/6ilvqec50fal/JdeBsAsNI2XepyM4IDL1U/ef2c96e26f7c3af5bce6db428cd1237f/Screenshot_2024-03-21_at_12.36.05_PM.png
22	Close-Grip Bench Press	2	\N	https://www.youtube.com/watch?v=XEFDMwmrLAM	\N	f	https://barbend.com/wp-content/uploads/2019/05/Barbend-Featured-Image-1600x900-A-person-doing-a-close-grip-barbell-bench-press-1.jpg
23	Overhead Tricep Extension	2	Can be done with a dumbbell or cable to hit different angles.	https://www.youtube.com/watch?v=kqidUIf1eJE	\N	f	https://www.dmoose.com/cdn/shop/articles/1_b930cb3e-8dac-4e45-9617-1d7b4594d264.png?v=1646823099
24	Tricep Pushdown	2	Uses a cable machine for isolation.	https://www.youtube.com/watch?v=LXkCrxn3caQ	\N	f	https://mirafit.co.uk/wp/wp-content/uploads/2022/11/tricep-pushdown-with-Mirafit-Cable-Machine-1-1024x683.jpg
25	Skull Crushers	2	Lying tricep extension usually performed with an EZ bar.	https://www.youtube.com/watch?v=jO2Jl9eZpXk	\N	f	https://www.dmoose.com/cdn/shop/articles/MicrosoftTeams-image_2_36a5ac4d-8ecb-4b12-91e7-b4f132f5333f.jpg?v=1682782075
26	Tricep Dips	2	Intense bodyweight exercise that targets the triceps.	https://www.youtube.com/watch?v=oA8Sxv2WeOs	\N	f	https://m.media-amazon.com/images/I/71knyjmUHOL._AC_UF350,350_QL80_.jpg
27	Step-ups	1	Utilizes a bench or platform, good for the thighs and glutes.	https://www.youtube.com/watch?v=9ZknEYboBOQ	\N	f	https://hips.hearstapps.com/hmg-prod/images/img-2358-jpg-1575476450.jpg
28	Calf Raises	1	Targets the calf muscles, can be done on a machine or with free weights.	https://www.youtube.com/watch?v=eMTy3qylqnE	\N	f	https://media.gq.com/photos/5a4fe56aefd792474cf8ce17/master/pass/2018-01_GQ_FITNESS-Ask-a-Trainer-Calfs.jpg
29	Leg Curls	1	Focuses on the hamstrings.	https://www.youtube.com/watch?v=Orxowest56U	\N	f	https://www.bodybuilding.com/images/2016/september/leg-curls-done-light-header-v2-960x540.jpg
30	Leg Press	1	Machine-based exercise that allows for heavy lifting with less back strain.	https://www.youtube.com/watch?v=yZmx_Ac3880	\N	f	https://ironbullstrength.com/cdn/shop/articles/leg_press_knee_pain.webp?v=1695829075
32	Squats	1	Fundamental exercise for overall leg development.	https://www.youtube.com/watch?v=nFAscG0XUNY	\N	f	https://steelsupplements.com/cdn/shop/articles/shutterstock_2018381615_1000x.jpg?v=1636630369
31	Lunges	1	Works each leg individually, promoting balance and muscle symmetry.	\N	\N	f	https://hips.hearstapps.com/hmg-prod/images/muscular-man-training-his-legs-doing-lunges-with-royalty-free-image-1677586874.jpg?crop=0.667xw:1.00xh;0.236xw,0&resize=1200:*
\.


--
-- TOC entry 3391 (class 0 OID 16390)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.users (id, first_name, last_name, email, password, created_at, is_admin) FROM stdin;
11	Mikołaj	Nogieć	nogiecmikolaj@gmail.com	$2y$10$5c8u/eDJM4hqBoOiwof7fOFonTI6lvlYU4ueAWAmsxvhVQMImeVtK	2024-05-14 17:51:35.207926+00	f
\.


--
-- TOC entry 3401 (class 0 OID 16461)
-- Dependencies: 226
-- Data for Name: workouts; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.workouts (id, exercise_id, user_id, date, sets, reps, weight) FROM stdin;
\.


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 217
-- Name: exercise_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.exercise_categories_id_seq', 5, true);


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 222
-- Name: exercises_creator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.exercises_creator_id_seq', 1, true);


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 220
-- Name: private_exercises_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.private_exercises_category_id_seq', 1, false);


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 219
-- Name: private_exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.private_exercises_id_seq', 32, true);


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.users_id_seq', 43, true);


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 224
-- Name: workouts_exercise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workouts_exercise_id_seq', 1, false);


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 223
-- Name: workouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workouts_id_seq', 1, false);


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 225
-- Name: workouts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workouts_user_id_seq', 1, false);


--
-- TOC entry 3236 (class 2606 OID 16410)
-- Name: exercise_categories exercise_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercise_categories
    ADD CONSTRAINT exercise_categories_name_key UNIQUE (name);


--
-- TOC entry 3238 (class 2606 OID 16408)
-- Name: exercise_categories exercise_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercise_categories
    ADD CONSTRAINT exercise_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 16457)
-- Name: exercises exercises_check_private_with_creator_id; Type: CHECK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE public.exercises
    ADD CONSTRAINT exercises_check_private_with_creator_id CHECK ((NOT (is_private AND (creator_id IS NULL)))) NOT VALID;


--
-- TOC entry 3240 (class 2606 OID 16437)
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 16400)
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- TOC entry 3234 (class 2606 OID 16398)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 16470)
-- Name: workouts workouts_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workouts
    ADD CONSTRAINT workouts_pkey PRIMARY KEY (id);


--
-- TOC entry 3243 (class 2606 OID 16438)
-- Name: exercises exercises_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.exercise_categories(id);


--
-- TOC entry 3244 (class 2606 OID 16451)
-- Name: exercises exercises_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 16471)
-- Name: workouts workouts_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workouts
    ADD CONSTRAINT workouts_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


--
-- TOC entry 3246 (class 2606 OID 16476)
-- Name: workouts workouts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workouts
    ADD CONSTRAINT workouts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


-- Completed on 2024-05-20 18:55:14 UTC

--
-- PostgreSQL database dump complete
--

