--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9
-- Dumped by pg_dump version 10.9

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.cache (
    user_id integer NOT NULL,
    cache_key character varying(128) DEFAULT ''::character varying NOT NULL,
    expires timestamp with time zone,
    data text NOT NULL
);


ALTER TABLE public.cache OWNER TO roundcube;

--
-- Name: cache_index; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.cache_index (
    user_id integer NOT NULL,
    mailbox character varying(255) NOT NULL,
    expires timestamp with time zone,
    valid smallint DEFAULT 0 NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.cache_index OWNER TO roundcube;

--
-- Name: cache_messages; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.cache_messages (
    user_id integer NOT NULL,
    mailbox character varying(255) NOT NULL,
    uid integer NOT NULL,
    expires timestamp with time zone,
    data text NOT NULL,
    flags integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_messages OWNER TO roundcube;

--
-- Name: cache_shared; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.cache_shared (
    cache_key character varying(255) NOT NULL,
    expires timestamp with time zone,
    data text NOT NULL
);


ALTER TABLE public.cache_shared OWNER TO roundcube;

--
-- Name: cache_thread; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.cache_thread (
    user_id integer NOT NULL,
    mailbox character varying(255) NOT NULL,
    expires timestamp with time zone,
    data text NOT NULL
);


ALTER TABLE public.cache_thread OWNER TO roundcube;

--
-- Name: contactgroupmembers; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.contactgroupmembers (
    contactgroup_id integer NOT NULL,
    contact_id integer NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contactgroupmembers OWNER TO roundcube;

--
-- Name: contactgroups; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.contactgroups (
    contactgroup_id integer DEFAULT nextval(('contactgroups_seq'::text)::regclass) NOT NULL,
    user_id integer NOT NULL,
    changed timestamp with time zone DEFAULT now() NOT NULL,
    del smallint DEFAULT 0 NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.contactgroups OWNER TO roundcube;

--
-- Name: contactgroups_seq; Type: SEQUENCE; Schema: public; Owner: roundcube
--

CREATE SEQUENCE public.contactgroups_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contactgroups_seq OWNER TO roundcube;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.contacts (
    contact_id integer DEFAULT nextval(('contacts_seq'::text)::regclass) NOT NULL,
    user_id integer NOT NULL,
    changed timestamp with time zone DEFAULT now() NOT NULL,
    del smallint DEFAULT 0 NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    firstname character varying(128) DEFAULT ''::character varying NOT NULL,
    surname character varying(128) DEFAULT ''::character varying NOT NULL,
    vcard text,
    words text
);


ALTER TABLE public.contacts OWNER TO roundcube;

--
-- Name: contacts_seq; Type: SEQUENCE; Schema: public; Owner: roundcube
--

CREATE SEQUENCE public.contacts_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contacts_seq OWNER TO roundcube;

--
-- Name: dictionary; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.dictionary (
    user_id integer,
    language character varying(5) NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.dictionary OWNER TO roundcube;

--
-- Name: identities; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.identities (
    identity_id integer DEFAULT nextval(('identities_seq'::text)::regclass) NOT NULL,
    user_id integer NOT NULL,
    changed timestamp with time zone DEFAULT now() NOT NULL,
    del smallint DEFAULT 0 NOT NULL,
    standard smallint DEFAULT 0 NOT NULL,
    name character varying(128) NOT NULL,
    organization character varying(128),
    email character varying(128) NOT NULL,
    "reply-to" character varying(128),
    bcc character varying(128),
    signature text,
    html_signature integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.identities OWNER TO roundcube;

--
-- Name: identities_seq; Type: SEQUENCE; Schema: public; Owner: roundcube
--

CREATE SEQUENCE public.identities_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.identities_seq OWNER TO roundcube;

--
-- Name: searches; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.searches (
    search_id integer DEFAULT nextval(('searches_seq'::text)::regclass) NOT NULL,
    user_id integer NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    name character varying(128) NOT NULL,
    data text NOT NULL
);


ALTER TABLE public.searches OWNER TO roundcube;

--
-- Name: searches_seq; Type: SEQUENCE; Schema: public; Owner: roundcube
--

CREATE SEQUENCE public.searches_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.searches_seq OWNER TO roundcube;

--
-- Name: session; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.session (
    sess_id character varying(128) DEFAULT ''::character varying NOT NULL,
    changed timestamp with time zone DEFAULT now() NOT NULL,
    ip character varying(41) NOT NULL,
    vars text NOT NULL
);


ALTER TABLE public.session OWNER TO roundcube;

--
-- Name: system; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.system (
    name character varying(64) NOT NULL,
    value text
);


ALTER TABLE public.system OWNER TO roundcube;

--
-- Name: users; Type: TABLE; Schema: public; Owner: roundcube
--

CREATE TABLE public.users (
    user_id integer DEFAULT nextval(('users_seq'::text)::regclass) NOT NULL,
    username character varying(128) DEFAULT ''::character varying NOT NULL,
    mail_host character varying(128) DEFAULT ''::character varying NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    last_login timestamp with time zone,
    failed_login timestamp with time zone,
    failed_login_counter integer,
    language character varying(5),
    preferences text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.users OWNER TO roundcube;

--
-- Name: users_seq; Type: SEQUENCE; Schema: public; Owner: roundcube
--

CREATE SEQUENCE public.users_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_seq OWNER TO roundcube;

--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.cache (user_id, cache_key, expires, data) FROM stdin;
\.


--
-- Data for Name: cache_index; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.cache_index (user_id, mailbox, expires, valid, data) FROM stdin;
\.


--
-- Data for Name: cache_messages; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.cache_messages (user_id, mailbox, uid, expires, data, flags) FROM stdin;
\.


--
-- Data for Name: cache_shared; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.cache_shared (cache_key, expires, data) FROM stdin;
\.


--
-- Data for Name: cache_thread; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.cache_thread (user_id, mailbox, expires, data) FROM stdin;
\.


--
-- Data for Name: contactgroupmembers; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.contactgroupmembers (contactgroup_id, contact_id, created) FROM stdin;
\.


--
-- Data for Name: contactgroups; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.contactgroups (contactgroup_id, user_id, changed, del, name) FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.contacts (contact_id, user_id, changed, del, name, email, firstname, surname, vcard, words) FROM stdin;
\.


--
-- Data for Name: dictionary; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.dictionary (user_id, language, data) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.identities (identity_id, user_id, changed, del, standard, name, organization, email, "reply-to", bcc, signature, html_signature) FROM stdin;
\.


--
-- Data for Name: searches; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.searches (search_id, user_id, type, name, data) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.session (sess_id, changed, ip, vars) FROM stdin;
\.


--
-- Data for Name: system; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.system (name, value) FROM stdin;
roundcube-version	2016112200
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: roundcube
--

COPY public.users (user_id, username, mail_host, created, last_login, failed_login, failed_login_counter, language, preferences) FROM stdin;
\.


--
-- Name: contactgroups_seq; Type: SEQUENCE SET; Schema: public; Owner: roundcube
--

SELECT pg_catalog.setval('public.contactgroups_seq', 1, false);


--
-- Name: contacts_seq; Type: SEQUENCE SET; Schema: public; Owner: roundcube
--

SELECT pg_catalog.setval('public.contacts_seq', 1, false);


--
-- Name: identities_seq; Type: SEQUENCE SET; Schema: public; Owner: roundcube
--

SELECT pg_catalog.setval('public.identities_seq', 1, false);


--
-- Name: searches_seq; Type: SEQUENCE SET; Schema: public; Owner: roundcube
--

SELECT pg_catalog.setval('public.searches_seq', 1, false);


--
-- Name: users_seq; Type: SEQUENCE SET; Schema: public; Owner: roundcube
--

SELECT pg_catalog.setval('public.users_seq', 1, false);


--
-- Name: cache_index cache_index_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache_index
    ADD CONSTRAINT cache_index_pkey PRIMARY KEY (user_id, mailbox);


--
-- Name: cache_messages cache_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache_messages
    ADD CONSTRAINT cache_messages_pkey PRIMARY KEY (user_id, mailbox, uid);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (user_id, cache_key);


--
-- Name: cache_shared cache_shared_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache_shared
    ADD CONSTRAINT cache_shared_pkey PRIMARY KEY (cache_key);


--
-- Name: cache_thread cache_thread_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache_thread
    ADD CONSTRAINT cache_thread_pkey PRIMARY KEY (user_id, mailbox);


--
-- Name: contactgroupmembers contactgroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.contactgroupmembers
    ADD CONSTRAINT contactgroupmembers_pkey PRIMARY KEY (contactgroup_id, contact_id);


--
-- Name: contactgroups contactgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.contactgroups
    ADD CONSTRAINT contactgroups_pkey PRIMARY KEY (contactgroup_id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (contact_id);


--
-- Name: dictionary dictionary_user_id_language_key; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.dictionary
    ADD CONSTRAINT dictionary_user_id_language_key UNIQUE (user_id, language);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (identity_id);


--
-- Name: searches searches_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.searches
    ADD CONSTRAINT searches_pkey PRIMARY KEY (search_id);


--
-- Name: searches searches_user_id_key; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.searches
    ADD CONSTRAINT searches_user_id_key UNIQUE (user_id, type, name);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sess_id);


--
-- Name: system system_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.system
    ADD CONSTRAINT system_pkey PRIMARY KEY (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username, mail_host);


--
-- Name: cache_expires_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX cache_expires_idx ON public.cache USING btree (expires);


--
-- Name: cache_index_expires_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX cache_index_expires_idx ON public.cache_index USING btree (expires);


--
-- Name: cache_messages_expires_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX cache_messages_expires_idx ON public.cache_messages USING btree (expires);


--
-- Name: cache_shared_expires_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX cache_shared_expires_idx ON public.cache_shared USING btree (expires);


--
-- Name: cache_thread_expires_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX cache_thread_expires_idx ON public.cache_thread USING btree (expires);


--
-- Name: contactgroupmembers_contact_id_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX contactgroupmembers_contact_id_idx ON public.contactgroupmembers USING btree (contact_id);


--
-- Name: contactgroups_user_id_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX contactgroups_user_id_idx ON public.contactgroups USING btree (user_id, del);


--
-- Name: contacts_user_id_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX contacts_user_id_idx ON public.contacts USING btree (user_id, del);


--
-- Name: identities_email_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX identities_email_idx ON public.identities USING btree (email, del);


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX identities_user_id_idx ON public.identities USING btree (user_id, del);


--
-- Name: session_changed_idx; Type: INDEX; Schema: public; Owner: roundcube
--

CREATE INDEX session_changed_idx ON public.session USING btree (changed);


--
-- Name: cache_index cache_index_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache_index
    ADD CONSTRAINT cache_index_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cache_messages cache_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache_messages
    ADD CONSTRAINT cache_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cache_thread cache_thread_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache_thread
    ADD CONSTRAINT cache_thread_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cache cache_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contactgroupmembers contactgroupmembers_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.contactgroupmembers
    ADD CONSTRAINT contactgroupmembers_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.contacts(contact_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contactgroupmembers contactgroupmembers_contactgroup_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.contactgroupmembers
    ADD CONSTRAINT contactgroupmembers_contactgroup_id_fkey FOREIGN KEY (contactgroup_id) REFERENCES public.contactgroups(contactgroup_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contactgroups contactgroups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.contactgroups
    ADD CONSTRAINT contactgroups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contacts contacts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dictionary dictionary_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.dictionary
    ADD CONSTRAINT dictionary_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: searches searches_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: roundcube
--

ALTER TABLE ONLY public.searches
    ADD CONSTRAINT searches_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

