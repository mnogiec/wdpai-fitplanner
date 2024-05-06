--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-06 18:54:14 UTC

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
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3203 (class 2604 OID 16393)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3207 (class 2606 OID 16400)
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- TOC entry 3209 (class 2606 OID 16398)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2024-05-06 18:54:14 UTC

--
-- PostgreSQL database dump complete
--

