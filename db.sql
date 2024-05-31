--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-31 20:00:53 UTC

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

--
-- TOC entry 233 (class 1255 OID 16537)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: docker
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO docker;

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
-- TOC entry 3439 (class 0 OID 0)
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
    image_url character varying(256),
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.exercises OWNER TO docker;

--
-- TOC entry 231 (class 1259 OID 16529)
-- Name: exercises_base_view; Type: VIEW; Schema: public; Owner: docker
--

CREATE VIEW public.exercises_base_view AS
 SELECT e.id,
    e.name,
    e.category_id,
    e.description,
    e.video_url,
    e.creator_id,
    e.is_private,
    e.image_url,
    e.updated_at,
    c.name AS category_name
   FROM (public.exercises e
     JOIN public.exercise_categories c ON ((e.category_id = c.id)));


ALTER VIEW public.exercises_base_view OWNER TO docker;

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
-- TOC entry 3440 (class 0 OID 0)
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
-- TOC entry 3441 (class 0 OID 0)
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
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 219
-- Name: private_exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.private_exercises_id_seq OWNED BY public.exercises.id;


--
-- TOC entry 232 (class 1259 OID 16533)
-- Name: private_exercises_view; Type: VIEW; Schema: public; Owner: docker
--

CREATE VIEW public.private_exercises_view AS
 SELECT e.id,
    e.name,
    e.category_id,
    e.description,
    e.video_url,
    e.creator_id,
    e.is_private,
    e.image_url,
    e.updated_at,
    c.name AS category_name
   FROM (public.exercises e
     JOIN public.exercise_categories c ON ((e.category_id = c.id)));


ALTER VIEW public.private_exercises_view OWNER TO docker;

--
-- TOC entry 228 (class 1259 OID 16483)
-- Name: workout_days; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.workout_days (
    id integer NOT NULL,
    date date NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.workout_days OWNER TO docker;

--
-- TOC entry 226 (class 1259 OID 16461)
-- Name: workout_exercises; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.workout_exercises (
    id integer NOT NULL,
    exercise_id integer NOT NULL,
    workout_day_id integer NOT NULL,
    sets bigint NOT NULL,
    reps bigint NOT NULL,
    weight numeric NOT NULL
);


ALTER TABLE public.workout_exercises OWNER TO docker;

--
-- TOC entry 230 (class 1259 OID 16523)
-- Name: user_workouts_view; Type: VIEW; Schema: public; Owner: docker
--

CREATE VIEW public.user_workouts_view AS
 SELECT wd.id AS day_id,
    wd.date,
    wd.user_id,
    we.id,
    we.sets,
    we.reps,
    we.weight,
    we.workout_day_id,
    e.name AS exercise_name,
    e.id AS exercise_id,
    e.category_id,
    e.description,
    e.video_url,
    e.creator_id,
    e.is_private,
    e.image_url
   FROM ((public.workout_days wd
     JOIN public.workout_exercises we ON ((wd.id = we.workout_day_id)))
     JOIN public.exercises e ON ((e.id = we.exercise_id)));


ALTER VIEW public.user_workouts_view OWNER TO docker;

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
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 227 (class 1259 OID 16482)
-- Name: workout_days_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.workout_days_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workout_days_id_seq OWNER TO docker;

--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 227
-- Name: workout_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workout_days_id_seq OWNED BY public.workout_days.id;


--
-- TOC entry 229 (class 1259 OID 16489)
-- Name: workout_days_user_id_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.workout_days_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workout_days_user_id_seq OWNER TO docker;

--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 229
-- Name: workout_days_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workout_days_user_id_seq OWNED BY public.workout_days.user_id;


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
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 224
-- Name: workouts_exercise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workouts_exercise_id_seq OWNED BY public.workout_exercises.exercise_id;


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
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 223
-- Name: workouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workouts_id_seq OWNED BY public.workout_exercises.id;


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
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 225
-- Name: workouts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.workouts_user_id_seq OWNED BY public.workout_exercises.workout_day_id;


--
-- TOC entry 3244 (class 2604 OID 16406)
-- Name: exercise_categories id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercise_categories ALTER COLUMN id SET DEFAULT nextval('public.exercise_categories_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 16432)
-- Name: exercises id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises ALTER COLUMN id SET DEFAULT nextval('public.private_exercises_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 16433)
-- Name: exercises category_id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises ALTER COLUMN category_id SET DEFAULT nextval('public.private_exercises_category_id_seq'::regclass);


--
-- TOC entry 3241 (class 2604 OID 16393)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 16486)
-- Name: workout_days id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_days ALTER COLUMN id SET DEFAULT nextval('public.workout_days_id_seq'::regclass);


--
-- TOC entry 3251 (class 2604 OID 16490)
-- Name: workout_days user_id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_days ALTER COLUMN user_id SET DEFAULT nextval('public.workout_days_user_id_seq'::regclass);


--
-- TOC entry 3249 (class 2604 OID 16464)
-- Name: workout_exercises id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_exercises ALTER COLUMN id SET DEFAULT nextval('public.workouts_id_seq'::regclass);


--
-- TOC entry 3422 (class 0 OID 16403)
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
-- TOC entry 3425 (class 0 OID 16429)
-- Dependencies: 221
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.exercises (id, name, category_id, description, video_url, creator_id, is_private, image_url, updated_at) FROM stdin;
10	T-Bar Row	4	Compound exercise for mid to upper back development.	https://www.youtube.com/watch?v=yPis7nlbqdY	\N	f	https://images.ctfassets.net/8urtyqugdt2l/5pziwWANOaPjQS2caLU8vd/83764919b6f35d9b053dd33bcb591fc9/t-bar-row-thumbnail.jpg	2024-05-31 19:22:58.911481+00
8	Back Extensions	4	Strengthen the lower back muscles.	https://www.youtube.com/watch?v=5_ejbGfdAQE	\N	f	https://hips.hearstapps.com/hmg-prod/images/screen-shot-2022-11-11-at-9-49-18-am-1668183899.png	2024-05-31 19:22:58.911481+00
2	Pec Deck Machine	5	Isolates the chest muscles with controlled movement.	https://www.youtube.com/watch?v=O-OBCfyh9Fw	\N	f	https://workouthealthy.com/cdn/shop/files/BS-DPEC-SF_Body-Solid-Pec-Deck-Rear-Delt-Fly-Machine.webp?v=1699486491	2024-05-31 19:22:58.911481+00
3	Dips	5	Emphasizes the lower chest and triceps when leaning forward.	https://www.youtube.com/watch?v=o2qX3Zb5mvg	\N	f	https://hips.hearstapps.com/hmg-prod/images/dips-1608221119.jpg?resize=980:*	2024-05-31 19:22:58.911481+00
4	Chest Flys	5	Can be done with dumbbells or a cable machine to enhance chest width and depth.	https://www.youtube.com/watch?v=eozdVDA78K0	\N	f	https://www.garagegymreviews.com/wp-content/uploads/woman-doing-an-incline-chest-fly.jpg	2024-05-31 19:22:58.911481+00
5	Incline Dumbbell Press	5	\N	https://www.youtube.com/watch?v=8iPEnn-ltC8	\N	f	https://www.dmoose.com/cdn/shop/articles/1_8a79831d-72ad-4d42-aca0-9bc7580f575b.jpg?v=1648826825	2024-05-31 19:22:58.911481+00
6	Push-ups	5	Versatile bodyweight exercise that targets the chest along with other upper body muscles.	https://www.youtube.com/watch?v=IODxDxX7oi4	\N	f	https://cdn.mos.cms.futurecdn.net/oYDbf5hQAePHEBNZTQMXRA.jpg	2024-05-31 19:22:58.911481+00
7	Bench Press	5	Standard exercise using a barbell to build the pectoral muscles.	https://www.youtube.com/watch?v=rT7DgCr-3pg	\N	f	https://www.trainheroic.com/wp-content/uploads/2021/09/Bench-press.jpg	2024-05-31 19:22:58.911481+00
9	Face Pulls	4	Improve rear deltoids and upper back muscles.	https://www.youtube.com/watch?v=0Po47vvj9g4	\N	f	https://www.garagegymreviews.com/wp-content/uploads/woman-performing-cable-face-pull.jpg	2024-05-31 19:22:58.911481+00
11	Lat Pulldowns	4	\N	https://www.youtube.com/watch?v=JGeRYIZdojU	\N	f	https://miro.medium.com/v2/resize:fit:1358/0*7g3xHWvaXcGhd2Ag.jpg	2024-05-31 19:22:58.911481+00
12	Bent-over Rows	4	Great for horizontal pulling strength, targeting mid-back.	https://www.youtube.com/watch?v=6FZHJGzMFEc	\N	f	https://hips.hearstapps.com/hmg-prod/images/joshua-simpson-kettlebell-vs-dumbbell-kb-bent-over-alternating-row-219-1636665510.jpg?crop=0.529xw:0.767xh;0.288xw,0.198xh&resize=1200:*	2024-05-31 19:22:58.911481+00
13	Deadlifts	4	\N	https://www.youtube.com/watch?v=AweC3UaM14o	\N	f	https://experiencelife.lifetime.life/wp-content/uploads/2021/08/f2-barbell-deadlift.jpg	2024-05-31 19:22:58.911481+00
14	Pull-ups	4	Strengthen the entire back and biceps with bodyweight.	https://www.youtube.com/watch?v=aAggnpPyR6E	\N	f	https://i0.wp.com/post.healthline.com/wp-content/uploads/2019/12/pull-up-pullup-gym-1296x728-header-1296x728.jpg?w=1155&h=1528	2024-05-31 19:22:58.911481+00
15	Chin-ups	3	Also works the biceps along with the back.	https://www.youtube.com/watch?v=8mryJ3w2S78	\N	f	https://media.self.com/photos/5bad13813f15b979ec0368eb/master/pass/woman-doing-chin-up.jpg	2024-05-31 19:22:58.911481+00
16	Cable Curl	3	Provides constant tension through the motion.	https://www.youtube.com/watch?v=opFVuRi_3b8	\N	f	https://origympersonaltrainercourses.co.uk/files/img_cache/9418/1920_1603357692_bicepcablecurl.JPG?1603357910	2024-05-31 19:22:58.911481+00
17	Peacher Curl	3	Stabilizes the arm, increasing isolation during the curl.	https://www.youtube.com/watch?v=Ja6ZlIDONac	\N	f	https://prod-ne-cdn-media.puregym.com/media/819541/preacher-curls.png?quality=80	2024-05-31 19:22:58.911481+00
18	Concentration Curl	3	Isolates one bicep at a time for focused tension.	https://www.youtube.com/watch?v=VMbDQ8PZazY	\N	f	https://cdn.muscleandstrength.com/sites/default/files/seated-concentration-curl.jpg	2024-05-31 19:22:58.911481+00
19	Hammer Curl	3	Targets the biceps and brachialis with a neutral grip.	https://www.youtube.com/watch?v=RIEMoYL_h1Y	\N	f	https://www.trainheroic.com/wp-content/uploads/2023/02/AdobeStock_417412809-TH-jpg.webp	2024-05-31 19:22:58.911481+00
20	Barbell Curl	3	Classic exercise for bicep growth.	https://www.youtube.com/watch?v=JnLFSFurrqQ	\N	f	https://mirafit.co.uk/wp/wp-content/uploads/2019/08/fitness-expert-doing-bicep-curls-with-an-ez-cutl-bar-1024x683.jpg	2024-05-31 19:22:58.911481+00
21	Diamond Push-ups	2	Bodyweight exercise focusing on the triceps and chest.	https://www.youtube.com/watch?v=XtU2VQVuLYs	\N	f	https://res.cloudinary.com/peloton-cycle/image/fetch/f_auto,c_limit,w_3840,q_90/https://images.ctfassets.net/6ilvqec50fal/JdeBsAsNI2XepyM4IDL1U/ef2c96e26f7c3af5bce6db428cd1237f/Screenshot_2024-03-21_at_12.36.05_PM.png	2024-05-31 19:22:58.911481+00
22	Close-Grip Bench Press	2	\N	https://www.youtube.com/watch?v=XEFDMwmrLAM	\N	f	https://barbend.com/wp-content/uploads/2019/05/Barbend-Featured-Image-1600x900-A-person-doing-a-close-grip-barbell-bench-press-1.jpg	2024-05-31 19:22:58.911481+00
23	Overhead Tricep Extension	2	Can be done with a dumbbell or cable to hit different angles.	https://www.youtube.com/watch?v=kqidUIf1eJE	\N	f	https://www.dmoose.com/cdn/shop/articles/1_b930cb3e-8dac-4e45-9617-1d7b4594d264.png?v=1646823099	2024-05-31 19:22:58.911481+00
24	Tricep Pushdown	2	Uses a cable machine for isolation.	https://www.youtube.com/watch?v=LXkCrxn3caQ	\N	f	https://mirafit.co.uk/wp/wp-content/uploads/2022/11/tricep-pushdown-with-Mirafit-Cable-Machine-1-1024x683.jpg	2024-05-31 19:22:58.911481+00
25	Skull Crushers	2	Lying tricep extension usually performed with an EZ bar.	https://www.youtube.com/watch?v=jO2Jl9eZpXk	\N	f	https://www.dmoose.com/cdn/shop/articles/MicrosoftTeams-image_2_36a5ac4d-8ecb-4b12-91e7-b4f132f5333f.jpg?v=1682782075	2024-05-31 19:22:58.911481+00
26	Tricep Dips	2	Intense bodyweight exercise that targets the triceps.	https://www.youtube.com/watch?v=oA8Sxv2WeOs	\N	f	https://m.media-amazon.com/images/I/71knyjmUHOL._AC_UF350,350_QL80_.jpg	2024-05-31 19:22:58.911481+00
27	Step-ups	1	Utilizes a bench or platform, good for the thighs and glutes.	https://www.youtube.com/watch?v=9ZknEYboBOQ	\N	f	https://hips.hearstapps.com/hmg-prod/images/img-2358-jpg-1575476450.jpg	2024-05-31 19:22:58.911481+00
28	Calf Raises	1	Targets the calf muscles, can be done on a machine or with free weights.	https://www.youtube.com/watch?v=eMTy3qylqnE	\N	f	https://media.gq.com/photos/5a4fe56aefd792474cf8ce17/master/pass/2018-01_GQ_FITNESS-Ask-a-Trainer-Calfs.jpg	2024-05-31 19:22:58.911481+00
29	Leg Curls	1	Focuses on the hamstrings.	https://www.youtube.com/watch?v=Orxowest56U	\N	f	https://www.bodybuilding.com/images/2016/september/leg-curls-done-light-header-v2-960x540.jpg	2024-05-31 19:22:58.911481+00
30	Leg Press	1	Machine-based exercise that allows for heavy lifting with less back strain.	https://www.youtube.com/watch?v=yZmx_Ac3880	\N	f	https://ironbullstrength.com/cdn/shop/articles/leg_press_knee_pain.webp?v=1695829075	2024-05-31 19:22:58.911481+00
31	Lunges	1	Works each leg individually, promoting balance and muscle symmetry.	\N	\N	f	https://hips.hearstapps.com/hmg-prod/images/muscular-man-training-his-legs-doing-lunges-with-royalty-free-image-1677586874.jpg?crop=0.667xw:1.00xh;0.236xw,0&resize=1200:*	2024-05-31 19:22:58.911481+00
32	Squats	1	Fundamental exercise for overall leg development.	https://www.youtube.com/watch?v=nFAscG0XUNY	\N	f	https://steelsupplements.com/cdn/shop/articles/shutterstock_2018381615_1000x.jpg?v=1636630369	2024-05-31 19:22:58.911481+00
\.


--
-- TOC entry 3420 (class 0 OID 16390)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.users (id, first_name, last_name, email, password, created_at, is_admin) FROM stdin;
11	Mikołaj	Nogieć	nogiecmikolaj@gmail.com	$2y$10$5c8u/eDJM4hqBoOiwof7fOFonTI6lvlYU4ueAWAmsxvhVQMImeVtK	2024-05-14 17:51:35.207926+00	t
44	Adam	Testowy	adamtestowy@gmail.com	$2y$10$T6x0Kd81wntpRSPNmqfoceVJqa2TROtmDHicessqaznakh.GwHQya	2024-05-31 20:00:00.258721+00	f
\.


--
-- TOC entry 3432 (class 0 OID 16483)
-- Dependencies: 228
-- Data for Name: workout_days; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.workout_days (id, date, user_id) FROM stdin;
2	2024-05-20	11
1	2024-05-21	11
3	2024-05-22	11
4	2024-05-30	11
5	2024-05-30	11
6	2024-05-30	11
7	2024-05-30	11
11	2024-05-31	11
\.


--
-- TOC entry 3430 (class 0 OID 16461)
-- Dependencies: 226
-- Data for Name: workout_exercises; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.workout_exercises (id, exercise_id, workout_day_id, sets, reps, weight) FROM stdin;
27	27	11	3	8	80
26	21	11	10	10	80
21	21	7	5	10	80
20	27	7	4	8	80
1	10	1	4	10	80
22	29	7	4	12	65
15	28	3	4	11	85.5
4	13	3	3	8	120
13	28	1	4	10	50
9	13	2	3	8	110
\.


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 217
-- Name: exercise_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.exercise_categories_id_seq', 5, true);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 222
-- Name: exercises_creator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.exercises_creator_id_seq', 1, true);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 220
-- Name: private_exercises_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.private_exercises_category_id_seq', 1, false);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 219
-- Name: private_exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.private_exercises_id_seq', 46, true);


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.users_id_seq', 44, true);


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 227
-- Name: workout_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workout_days_id_seq', 11, true);


--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 229
-- Name: workout_days_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workout_days_user_id_seq', 1, false);


--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 224
-- Name: workouts_exercise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workouts_exercise_id_seq', 1, false);


--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 223
-- Name: workouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workouts_id_seq', 27, true);


--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 225
-- Name: workouts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.workouts_user_id_seq', 1, false);


--
-- TOC entry 3258 (class 2606 OID 16410)
-- Name: exercise_categories exercise_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercise_categories
    ADD CONSTRAINT exercise_categories_name_key UNIQUE (name);


--
-- TOC entry 3260 (class 2606 OID 16408)
-- Name: exercise_categories exercise_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercise_categories
    ADD CONSTRAINT exercise_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3252 (class 2606 OID 16457)
-- Name: exercises exercises_check_private_with_creator_id; Type: CHECK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE public.exercises
    ADD CONSTRAINT exercises_check_private_with_creator_id CHECK ((NOT (is_private AND (creator_id IS NULL)))) NOT VALID;


--
-- TOC entry 3262 (class 2606 OID 16437)
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 16400)
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- TOC entry 3256 (class 2606 OID 16398)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3266 (class 2606 OID 16488)
-- Name: workout_days workout_days_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_days
    ADD CONSTRAINT workout_days_pkey PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 16470)
-- Name: workout_exercises workouts_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_exercises
    ADD CONSTRAINT workouts_pkey PRIMARY KEY (id);


--
-- TOC entry 3272 (class 2620 OID 16538)
-- Name: exercises update_exercises_updated_at; Type: TRIGGER; Schema: public; Owner: docker
--

CREATE TRIGGER update_exercises_updated_at BEFORE UPDATE ON public.exercises FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 3267 (class 2606 OID 16438)
-- Name: exercises exercises_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.exercise_categories(id);


--
-- TOC entry 3268 (class 2606 OID 16451)
-- Name: exercises exercises_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3271 (class 2606 OID 16495)
-- Name: workout_days workout_days_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_days
    ADD CONSTRAINT workout_days_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 3269 (class 2606 OID 16500)
-- Name: workout_exercises workout_exercises_workout_day_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_exercises
    ADD CONSTRAINT workout_exercises_workout_day_id_fkey FOREIGN KEY (workout_day_id) REFERENCES public.workout_days(id) NOT VALID;


--
-- TOC entry 3270 (class 2606 OID 16471)
-- Name: workout_exercises workouts_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.workout_exercises
    ADD CONSTRAINT workouts_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id);


-- Completed on 2024-05-31 20:00:53 UTC

--
-- PostgreSQL database dump complete
--

