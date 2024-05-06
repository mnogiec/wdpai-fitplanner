--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-06 19:32:41 UTC

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
5	Incline Dumbbell Press	5	\N	\N	\N	f	\N
2	Pec Deck Machine	5	Isolates the chest muscles with controlled movement.	\N	\N	f	\N
3	Dips	5	Emphasizes the lower chest and triceps when leaning forward.	\N	\N	f	\N
4	Chest Flys	5	Can be done with dumbbells or a cable machine to enhance chest width and depth.	\N	\N	f	\N
6	Push-ups	5	Versatile bodyweight exercise that targets the chest along with other upper body muscles.	\N	\N	f	\N
7	Bench Press	5	Standard exercise using a barbell to build the pectoral muscles.	\N	\N	f	\N
8	Back Extensions	4	Strengthen the lower back muscles.	\N	\N	f	\N
9	Face Pulls	4	Improve rear deltoids and upper back muscles.	\N	\N	f	\N
10	T-Bar Row	4	Compound exercise for mid to upper back development.	\N	\N	f	\N
11	Lat Pulldowns	4	\N	\N	\N	f	\N
12	Bent-over Rows	4	Great for horizontal pulling strength, targeting mid-back.	\N	\N	f	\N
13	Deadlifts	4	\N	\N	\N	f	\N
14	Pull-ups	4	Strengthen the entire back and biceps with bodyweight.	\N	\N	f	\N
15	Chin-ups	3	Also works the biceps along with the back.	\N	\N	f	\N
16	Cable Curl	3	Provides constant tension through the motion.	\N	\N	f	\N
17	Peacher Curl	3	Stabilizes the arm, increasing isolation during the curl.	\N	\N	f	\N
18	Concentration Curl	3	Isolates one bicep at a time for focused tension.	\N	\N	f	\N
19	Hammer Curl	3	Targets the biceps and brachialis with a neutral grip.	\N	\N	f	\N
20	Barbell Curl	3	Classic exercise for bicep growth.	\N	\N	f	\N
21	Diamond Push-ups	2	Bodyweight exercise focusing on the triceps and chest.	\N	\N	f	\N
22	Close-Grip Bench Press	2	\N	\N	\N	f	\N
23	Overhead Tricep Extension	2	Can be done with a dumbbell or cable to hit different angles.	\N	\N	f	\N
24	Tricep Pushdown	2	Uses a cable machine for isolation.	\N	\N	f	\N
25	Skull Crushers	2	Lying tricep extension usually performed with an EZ bar.	\N	\N	f	\N
26	Tricep Dips	2	Intense bodyweight exercise that targets the triceps.	\N	\N	f	\N
27	Step-ups	1	Utilizes a bench or platform, good for the thighs and glutes.	\N	\N	f	\N
28	Calf Raises	1	Targets the calf muscles, can be done on a machine or with free weights.	\N	\N	f	\N
29	Leg Curls	1	Focuses on the hamstrings.	\N	\N	f	\N
30	Leg Press	1	Machine-based exercise that allows for heavy lifting with less back strain.	\N	\N	f	\N
31	Lunges	1	Works each leg individually, promoting balance and muscle symmetry.	\N	\N	f	\N
32	Squats	1	Fundamental exercise for overall leg development.	\N	\N	f	\N
\.


--
-- TOC entry 3391 (class 0 OID 16390)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.users (id, first_name, last_name, email, password, created_at, is_admin) FROM stdin;
8	Mikołaj	Nogieć	nogiecmikolaj@gmail.com	$2y$10$19wCmMVejOpKhZd3Vs/JdOXTfH.xw5nlJWlGwdptxhFuqRSbnw97y	2024-05-03 13:27:08.067154+00	f
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

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


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


-- Completed on 2024-05-06 19:32:41 UTC

--
-- PostgreSQL database dump complete
--

