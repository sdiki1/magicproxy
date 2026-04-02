--
-- PostgreSQL database dump
--

\restrict 28oID2OwaKLQtNW7wFtvSF1dn4KnTayEF078uDxQ8pv2apJwvafSPcHdO4MpNbe

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13 (Homebrew)

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
-- Name: banned_users; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.banned_users (
    id bigint NOT NULL,
    tg_user_id bigint NOT NULL,
    reason text NOT NULL,
    blocked_by bigint,
    blocked_at bigint NOT NULL
);


ALTER TABLE public.banned_users OWNER TO proxybotuserrsuisuusus;

--
-- Name: banned_users_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.banned_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banned_users_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: banned_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.banned_users_id_seq OWNED BY public.banned_users.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    plan_code text NOT NULL,
    amount_rub integer NOT NULL,
    months_count integer DEFAULT 1 NOT NULL,
    target_tg_user_id bigint,
    yookassa_payment_id text,
    yookassa_confirmation_url text,
    status text NOT NULL,
    created_at bigint NOT NULL,
    paid_at bigint,
    CONSTRAINT payments_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'paid'::text, 'cancelled'::text])))
);


ALTER TABLE public.payments OWNER TO proxybotuserrsuisuusus;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: plans; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.plans (
    code text NOT NULL,
    title text NOT NULL,
    devices_count integer NOT NULL,
    price_rub integer NOT NULL,
    duration_days integer NOT NULL
);


ALTER TABLE public.plans OWNER TO proxybotuserrsuisuusus;

--
-- Name: proxy_delivery_logs; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.proxy_delivery_logs (
    id bigint NOT NULL,
    proxy_link_id bigint NOT NULL,
    user_id bigint NOT NULL,
    tg_user_id bigint NOT NULL,
    user_label text NOT NULL,
    subscription_id bigint,
    device_number integer,
    delivery_source text NOT NULL,
    proxy_url text NOT NULL,
    delivered_at bigint NOT NULL,
    CONSTRAINT proxy_delivery_logs_delivery_source_check CHECK ((delivery_source = ANY (ARRAY['purchase'::text, 'my_links'::text])))
);


ALTER TABLE public.proxy_delivery_logs OWNER TO proxybotuserrsuisuusus;

--
-- Name: proxy_delivery_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.proxy_delivery_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proxy_delivery_logs_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: proxy_delivery_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.proxy_delivery_logs_id_seq OWNED BY public.proxy_delivery_logs.id;


--
-- Name: proxy_links; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.proxy_links (
    id bigint NOT NULL,
    subscription_id bigint NOT NULL,
    user_id bigint NOT NULL,
    device_number integer NOT NULL,
    token text NOT NULL,
    link text NOT NULL,
    status text NOT NULL,
    created_at bigint NOT NULL,
    expires_at bigint NOT NULL,
    CONSTRAINT proxy_links_status_check CHECK ((status = ANY (ARRAY['active'::text, 'expired'::text])))
);


ALTER TABLE public.proxy_links OWNER TO proxybotuserrsuisuusus;

--
-- Name: proxy_links_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.proxy_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proxy_links_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: proxy_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.proxy_links_id_seq OWNED BY public.proxy_links.id;


--
-- Name: proxy_pool; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.proxy_pool (
    id bigint NOT NULL,
    port integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    status text NOT NULL,
    assigned_link_id bigint,
    created_at bigint NOT NULL,
    updated_at bigint NOT NULL,
    CONSTRAINT proxy_pool_status_check CHECK ((status = ANY (ARRAY['free'::text, 'assigned'::text])))
);


ALTER TABLE public.proxy_pool OWNER TO proxybotuserrsuisuusus;

--
-- Name: proxy_pool_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.proxy_pool_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proxy_pool_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: proxy_pool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.proxy_pool_id_seq OWNED BY public.proxy_pool.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.subscriptions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    plan_code text NOT NULL,
    payment_id bigint NOT NULL,
    status text NOT NULL,
    created_at bigint NOT NULL,
    expires_at bigint NOT NULL,
    notified_expired integer DEFAULT 0 NOT NULL,
    notified_expiring_2days integer DEFAULT 0 NOT NULL,
    CONSTRAINT subscriptions_status_check CHECK ((status = ANY (ARRAY['active'::text, 'expired'::text])))
);


ALTER TABLE public.subscriptions OWNER TO proxybotuserrsuisuusus;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscriptions_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: user_temp_messages; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.user_temp_messages (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    tg_user_id bigint NOT NULL,
    message_id bigint NOT NULL,
    kind text NOT NULL,
    created_at bigint NOT NULL
);


ALTER TABLE public.user_temp_messages OWNER TO proxybotuserrsuisuusus;

--
-- Name: user_temp_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.user_temp_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_temp_messages_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: user_temp_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.user_temp_messages_id_seq OWNED BY public.user_temp_messages.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    tg_user_id bigint NOT NULL,
    username text,
    first_name text,
    last_name text,
    created_at bigint NOT NULL,
    updated_at bigint NOT NULL
);


ALTER TABLE public.users OWNER TO proxybotuserrsuisuusus;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO proxybotuserrsuisuusus;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: banned_users id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.banned_users ALTER COLUMN id SET DEFAULT nextval('public.banned_users_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: proxy_delivery_logs id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_delivery_logs ALTER COLUMN id SET DEFAULT nextval('public.proxy_delivery_logs_id_seq'::regclass);


--
-- Name: proxy_links id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_links ALTER COLUMN id SET DEFAULT nextval('public.proxy_links_id_seq'::regclass);


--
-- Name: proxy_pool id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_pool ALTER COLUMN id SET DEFAULT nextval('public.proxy_pool_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: user_temp_messages id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.user_temp_messages ALTER COLUMN id SET DEFAULT nextval('public.user_temp_messages_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: banned_users; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.banned_users (id, tg_user_id, reason, blocked_by, blocked_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.payments (id, user_id, plan_code, amount_rub, months_count, target_tg_user_id, yookassa_payment_id, yookassa_confirmation_url, status, created_at, paid_at) FROM stdin;
1	11	one	10	1	558396308	312e7763-000f-5000-b000-195adfa20b2a	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312e7763-000f-5000-b000-195adfa20b2a	pending	1771856803	\N
124	11	one	10	1	558396308	31499e9f-000f-5001-9000-15ea30299b8b	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31499e9f-000f-5001-9000-15ea30299b8b	pending	1773636320	\N
2	1	one	10	1	1924535035	312e7878-000f-5000-8000-16255ce06499	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312e7878-000f-5000-8000-16255ce06499	paid	1771857080	1771857147
3	11	one	10	1	558396308	312e78e7-000f-5001-9000-1553f3af7b1c	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312e78e7-000f-5001-9000-1553f3af7b1c	paid	1771857191	1771857251
4	11	one	10	1	558396308	312e85fc-000f-5000-8000-198a037ce49b	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312e85fc-000f-5000-8000-198a037ce49b	pending	1771860540	\N
5	11	one	10	1	558396308	312e9120-000f-5000-b000-12bd1281b650	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312e9120-000f-5000-b000-12bd1281b650	cancelled	1771863392	\N
6	11	one	10	1	558396308	312e924a-000f-5000-b000-1be46ecdf298	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312e924a-000f-5000-b000-1be46ecdf298	cancelled	1771863690	\N
7	11	one	10	1	558396308	312e9267-000f-5000-b000-1ab4b8b5ca3e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312e9267-000f-5000-b000-1ab4b8b5ca3e	paid	1771863719	1771864096
8	1	one	10	1	1088192644	312ee48b-000f-5000-8000-1b970a80b378	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312ee48b-000f-5000-8000-1b970a80b378	pending	1771884747	\N
9	1	one	10	1	1924535035	312eeadf-000f-5000-b000-145e0eac3034	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312eeadf-000f-5000-b000-145e0eac3034	pending	1771886368	\N
10	1	one	10	1	1924535035	312eeaea-000f-5001-8000-1c552725e462	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312eeaea-000f-5001-8000-1c552725e462	pending	1771886378	\N
11	1	one	30	3	1924535035	312eeb1e-000f-5000-b000-1416125bb3bf	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312eeb1e-000f-5000-b000-1416125bb3bf	pending	1771886430	\N
12	11	one	10	1	558396308	312f49c9-000f-5001-9000-1a5ab2d7d79d	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f49c9-000f-5001-9000-1a5ab2d7d79d	cancelled	1771910665	\N
13	11	one	10	1	853700754	312f4beb-000f-5001-8000-187307f9ce83	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f4beb-000f-5001-8000-187307f9ce83	cancelled	1771911211	\N
14	11	one	10	1	558396308	312f4c11-000f-5001-8000-162a83258c2b	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f4c11-000f-5001-8000-162a83258c2b	paid	1771911249	1771911418
15	11	one	10	1	558396308	312f4e7a-000f-5001-9000-181a87266c8a	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f4e7a-000f-5001-9000-181a87266c8a	pending	1771911866	\N
16	11	one	10	1	7176003171	312f50cd-000f-5001-9000-1779fe975cdb	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f50cd-000f-5001-9000-1779fe975cdb	paid	1771912461	1771912508
17	11	one	10	1	7176003171	312f52e3-000f-5001-8000-1aa950b5a369	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f52e3-000f-5001-8000-1aa950b5a369	pending	1771912996	\N
18	11	one	10	1	558396308	312f53b6-000f-5001-8000-18156679ba32	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f53b6-000f-5001-8000-18156679ba32	pending	1771913207	\N
19	11	one	10	1	558396308	312f54c1-000f-5000-8000-14ec344d14c4	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f54c1-000f-5000-8000-14ec344d14c4	paid	1771913473	1771913545
20	11	one	10	1	558396308	312f5f85-000f-5000-b000-1231c8ed125a	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f5f85-000f-5000-b000-1231c8ed125a	pending	1771916229	\N
21	382	five	25	1	903449432	312f7e33-000f-5001-9000-1532a62006b5	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f7e33-000f-5001-9000-1532a62006b5	paid	1771924084	1771924136
22	11	one	10	1	558396308	312f8695-000f-5000-8000-14f2d17d7282	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f8695-000f-5000-8000-14f2d17d7282	cancelled	1771926229	\N
23	11	one	10	1	374962741	312f939b-000f-5001-9000-1db9716db843	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312f939b-000f-5001-9000-1db9716db843	paid	1771929564	1771929625
24	11	one	10	1	558396308	312fa001-000f-5001-8000-1f0068ba74aa	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fa001-000f-5001-8000-1f0068ba74aa	pending	1771932737	\N
25	11	one	0	1	\N	\N	\N	paid	1771934483	1771934483
26	11	one	10	1	558396308	312fa769-000f-5001-9000-12c0b04ad720	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fa769-000f-5001-9000-12c0b04ad720	pending	1771934633	\N
27	1	one	10	1	1924535035	312fa8d7-000f-5001-8000-169afee61589	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fa8d7-000f-5001-8000-169afee61589	pending	1771934999	\N
28	11	one	10	1	558396308	312fa9a1-000f-5001-9000-18e32008c609	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fa9a1-000f-5001-9000-18e32008c609	pending	1771935201	\N
29	11	one	10	1	558396308	312faaa9-000f-5001-8000-1f265c7accbd	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312faaa9-000f-5001-8000-1f265c7accbd	paid	1771935465	1771935522
30	11	one	10	1	558396308	312fac37-000f-5001-9000-1fec52d358c9	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fac37-000f-5001-9000-1fec52d358c9	paid	1771935863	1771935875
31	11	fifteen	50	1	558396308	312fad63-000f-5000-b000-1d148e20246f	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fad63-000f-5000-b000-1d148e20246f	pending	1771936163	\N
32	11	one	10	1	558396308	312fadc1-000f-5000-8000-15023c8507ab	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fadc1-000f-5000-8000-15023c8507ab	pending	1771936258	\N
33	11	one	60	6	558396308	312fae5f-000f-5001-9000-1aba63582275	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fae5f-000f-5001-9000-1aba63582275	cancelled	1771936415	\N
66	11	one	10	1	558396308	312faefd-000f-5000-8000-11b5dde59616	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312faefd-000f-5000-8000-11b5dde59616	paid	1771936573	1771936660
67	11	one	30	3	558396308	312faf88-000f-5000-b000-141d09664a8e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312faf88-000f-5000-b000-141d09664a8e	cancelled	1771936712	\N
68	11	one	10	1	558396308	312fafa7-000f-5001-8000-196fe03b8c3d	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fafa7-000f-5001-8000-196fe03b8c3d	cancelled	1771936744	\N
69	11	one	10	1	558396308	312fb028-000f-5001-8000-139190e2d79d	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb028-000f-5001-8000-139190e2d79d	paid	1771936873	1771936937
70	11	one	10	1	7176003171	312fb0c2-000f-5001-8000-1445304f1ebe	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb0c2-000f-5001-8000-1445304f1ebe	paid	1771937026	1771937059
71	11	one	10	1	558396308	312fb142-000f-5001-8000-10e870d83449	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb142-000f-5001-8000-10e870d83449	pending	1771937154	\N
72	11	one	10	1	7176003171	312fb3db-000f-5001-8000-1a126a78a311	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb3db-000f-5001-8000-1a126a78a311	cancelled	1771937820	\N
73	11	one	10	1	558396308	312fb475-000f-5001-9000-1c70a5cc53d4	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb475-000f-5001-9000-1c70a5cc53d4	pending	1771937973	\N
74	11	one	10	1	558396308	312fb4d7-000f-5001-9000-13b7e92133d5	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb4d7-000f-5001-9000-13b7e92133d5	pending	1771938071	\N
75	11	one	10	1	558396308	312fb57d-000f-5001-9000-14bc4140682e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb57d-000f-5001-9000-14bc4140682e	pending	1771938237	\N
76	767	one	10	1	1417827742	312fb6ef-000f-5000-b000-1c7234f3a7c7	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb6ef-000f-5000-b000-1c7234f3a7c7	paid	1771938607	1771938619
77	776	one	10	1	5285135313	312fb96d-000f-5000-8000-1b4e3bd436f0	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fb96d-000f-5000-8000-1b4e3bd436f0	paid	1771939245	1771939346
78	11	one	10	1	7176003171	312fbf09-000f-5001-9000-1d6188492895	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fbf09-000f-5001-9000-1d6188492895	cancelled	1771940681	\N
79	11	one	10	1	7176003171	312fc27f-000f-5001-9000-1bf533e924ce	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fc27f-000f-5001-9000-1bf533e924ce	cancelled	1771941567	\N
80	11	one	10	1	7176003171	312fc29d-000f-5000-8000-1280d53ead79	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fc29d-000f-5000-8000-1280d53ead79	cancelled	1771941597	\N
81	11	one	10	1	7176003171	312fc315-000f-5000-b000-10163262275e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fc315-000f-5000-b000-10163262275e	cancelled	1771941717	\N
82	11	one	10	1	558396308	312fc4bb-000f-5000-8000-11daa8d8afeb	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fc4bb-000f-5000-8000-11daa8d8afeb	pending	1771942139	\N
83	1	five	75	3	1088192644	312fc537-000f-5001-9000-10ebeee181dd	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fc537-000f-5001-9000-10ebeee181dd	pending	1771942263	\N
84	11	one	120	12	558396308	312fc5c3-000f-5000-b000-15802e488a54	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fc5c3-000f-5000-b000-15802e488a54	pending	1771942403	\N
85	11	one	10	1	558396308	312fc5f9-000f-5000-b000-16bed9712d8c	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fc5f9-000f-5000-b000-16bed9712d8c	cancelled	1771942457	\N
86	296	one	10	1	853700754	312fcb96-000f-5001-8000-10fb336cedce	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fcb96-000f-5001-8000-10fb336cedce	paid	1771943894	1771943908
87	1135	five	25	1	854988710	312fcd55-000f-5001-8000-18d62f5d4093	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fcd55-000f-5001-8000-18d62f5d4093	paid	1771944341	1771944425
88	1143	one	10	1	1076638199	312fce53-000f-5000-8000-17b5edbc28e1	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fce53-000f-5000-8000-17b5edbc28e1	paid	1771944595	1771944684
89	1149	one	10	1	737412186	312fcef9-000f-5001-8000-1aa94e5b2219	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fcef9-000f-5001-8000-1aa94e5b2219	paid	1771944761	1771944816
90	1154	one	10	1	861362028	312fcf0b-000f-5000-b000-1d247e1e8e23	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fcf0b-000f-5000-b000-1d247e1e8e23	paid	1771944779	1771944830
91	1161	one	10	1	1091492352	312fd08b-000f-5000-b000-1d07389791dc	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fd08b-000f-5000-b000-1d07389791dc	paid	1771945163	1771945368
92	1172	one	10	1	64504614	312fd61c-000f-5001-8000-1e899b4f9a3d	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fd61c-000f-5001-8000-1e899b4f9a3d	paid	1771946588	1771946596
93	11	one	10	1	1580415068	312fd90a-000f-5001-9000-1509d2e2946b	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fd90a-000f-5001-9000-1509d2e2946b	paid	1771947339	1771947390
94	1195	one	30	3	5416731973	312fdd28-000f-5001-9000-1556a6bede19	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fdd28-000f-5001-9000-1556a6bede19	paid	1771948392	1771948492
95	1203	one	10	1	459584886	312fde19-000f-5001-9000-13995f31fce3	https://yoomoney.ru/checkout/payments/v2/contract?orderId=312fde19-000f-5001-9000-13995f31fce3	paid	1771948633	1771948673
96	1211	one	0	1	\N	\N	\N	paid	1771949566	1771949566
97	1118	one	0	1	\N	\N	\N	paid	1771951955	1771951955
98	775	one	10	1	1144391790	313000d7-000f-5001-8000-1a5943e8e1ca	https://yoomoney.ru/checkout/payments/v2/contract?orderId=313000d7-000f-5001-8000-1a5943e8e1ca	paid	1771957527	1771957732
99	11	one	10	1	558396308	3130a14c-000f-5000-8000-1c373a16ca81	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3130a14c-000f-5000-8000-1c373a16ca81	cancelled	1771998605	\N
100	11	one	10	1	558396308	3130a15e-000f-5001-8000-1b53d191870c	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3130a15e-000f-5001-8000-1b53d191870c	cancelled	1771998622	\N
101	11	one	10	1	558396308	3130a168-000f-5001-9000-19ff0342a870	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3130a168-000f-5001-9000-19ff0342a870	cancelled	1771998632	\N
102	11	one	10	1	558396308	3130a173-000f-5000-8000-10e1a552a52e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3130a173-000f-5000-8000-10e1a552a52e	cancelled	1771998643	\N
125	1544	one	10	1	794762280	3149e23c-000f-5001-8000-1057bdb59097	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3149e23c-000f-5001-8000-1057bdb59097	paid	1773653628	1773653698
103	11	one	10	1	558396308	3130a17c-000f-5000-b000-1fe85a856104	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3130a17c-000f-5000-b000-1fe85a856104	cancelled	1771998653	\N
104	1298	one	10	1	5774369853	3130aaf3-000f-5000-b000-195407410f45	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3130aaf3-000f-5000-b000-195407410f45	pending	1772001075	\N
126	1557	one	10	1	667253174	3149f6c7-000f-5001-9000-10b28d7b01e0	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3149f6c7-000f-5001-9000-10b28d7b01e0	pending	1773658887	\N
105	1254	one	0	1	\N	\N	\N	paid	1772022156	1772022156
106	1331	one	10	1	2043764535	31316055-000f-5001-8000-1b162f680fb7	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31316055-000f-5001-8000-1b162f680fb7	pending	1772047510	\N
127	1544	one	10	1	89104148683	3149f71a-000f-5001-8000-157e63752be1	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3149f71a-000f-5001-8000-157e63752be1	paid	1773658970	1773659010
108	1350	five	300	12	262746320	31328404-000f-5001-8000-1bc289f2b1d3	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31328404-000f-5001-8000-1bc289f2b1d3	paid	1772122180	1772122264
107	1337	fifteen	50	1	509553101	31321f4b-000f-5001-9000-1a9d41e8c8d0	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31321f4b-000f-5001-9000-1a9d41e8c8d0	cancelled	1772096395	\N
109	1337	fifteen	300	6	509553101	31334d85-000f-5000-b000-12e345b19031	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31334d85-000f-5000-b000-12e345b19031	cancelled	1772173766	\N
128	11	one	0	1	\N	\N	\N	paid	1773659496	1773659496
110	1337	fifteen	600	12	509553101	31334d98-000f-5001-8000-1c129aa8a45d	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31334d98-000f-5001-8000-1c129aa8a45d	paid	1772173784	1772174015
111	1389	one	120	12	1290146931	31337d46-000f-5001-9000-101a3d5787f0	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31337d46-000f-5001-9000-101a3d5787f0	paid	1772185990	1772186027
129	1584	one	10	1	979320559	314a538e-000f-5000-8000-1b4f47496e0b	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314a538e-000f-5000-8000-1b4f47496e0b	paid	1773682638	1773682724
112	11	one	0	1	\N	\N	\N	paid	1772367963	1772367963
113	11	one	0	1	\N	\N	\N	paid	1772368186	1772368186
130	11	one	0	1	\N	\N	\N	paid	1773817747	1773817747
114	11	one	10	1	558396308	31364998-000f-5001-9000-1ca075fa2146	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31364998-000f-5001-9000-1ca075fa2146	cancelled	1772369368	\N
115	1445	five	25	1	665410048	31392e44-000f-5000-8000-123895c07d49	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31392e44-000f-5000-8000-123895c07d49	paid	1772558980	1772559044
131	1624	fifteen	600	12	8618772238	314cb33d-000f-5000-b000-1bb40dd99f71	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314cb33d-000f-5000-b000-1bb40dd99f71	paid	1773838205	1773838369
116	1453	fifteen	600	12	6048846195	313a1ec3-000f-5001-9000-1b2208b4e1f6	https://yoomoney.ru/checkout/payments/v2/contract?orderId=313a1ec3-000f-5001-9000-1b2208b4e1f6	paid	1772620547	1772620692
117	11	one	10	1	558396308	313e5257-000f-5000-b000-19e0f5da6429	https://yoomoney.ru/checkout/payments/v2/contract?orderId=313e5257-000f-5000-b000-19e0f5da6429	pending	1772895895	\N
132	1638	one	60	6	720204235	314dd460-000f-5001-8000-111feadf8908	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314dd460-000f-5001-8000-111feadf8908	pending	1773912224	\N
118	1230	one	120	12	266186319	313f2d14-000f-5001-8000-1d9cd8cb9473	https://yoomoney.ru/checkout/payments/v2/contract?orderId=313f2d14-000f-5001-8000-1d9cd8cb9473	paid	1772951892	1772951945
119	1492	one	0	1	\N	\N	\N	paid	1773085430	1773085430
120	1462	one	10	1	5469749689	3141db63-000f-5000-b000-14faa3347ff6	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3141db63-000f-5000-b000-14faa3347ff6	pending	1773127587	\N
134	11	one	10	1	558396308	314dd4d7-000f-5001-9000-15f956952d61	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314dd4d7-000f-5001-9000-15f956952d61	pending	1773912343	\N
121	1462	one	10	1	5469749689	3144b77a-000f-5001-9000-155208e59e4e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3144b77a-000f-5001-9000-155208e59e4e	cancelled	1773315002	\N
122	1533	one	10	1	8423198471	31479f92-000f-5001-8000-1f0c1e7e0ff5	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31479f92-000f-5001-8000-1f0c1e7e0ff5	pending	1773505490	\N
133	1638	one	10	1	519070845	314dd49f-000f-5001-8000-17fab523b16d	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314dd49f-000f-5001-8000-17fab523b16d	cancelled	1773912287	\N
123	11	one	0	1	\N	\N	\N	paid	1773580226	1773580226
135	1638	one	10	1	720204235	314dd559-000f-5000-b000-1d1a763bd54f	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314dd559-000f-5000-b000-1d1a763bd54f	paid	1773912473	1773912486
136	1	fifteen	0	1	\N	\N	\N	paid	1773916855	1773916855
137	1462	one	10	1	5469749689	314df283-000f-5000-8000-1e32b5775e32	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314df283-000f-5000-8000-1e32b5775e32	pending	1773919939	\N
138	1702	one	10	1	553941277	314e068f-000f-5001-8000-163475d56bdc	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314e068f-000f-5001-8000-163475d56bdc	paid	1773925071	1773925424
139	1713	one	10	1	5888026625	314f128a-000f-5001-8000-11b050ea32f2	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f128a-000f-5001-8000-11b050ea32f2	paid	1773993674	1773993738
140	1714	five	25	1	439864771	314f1292-000f-5000-b000-107fcd454e54	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f1292-000f-5000-b000-107fcd454e54	paid	1773993682	1773993751
142	1734	one	10	1	1155492418	314f13bc-000f-5001-9000-1f414d43364e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f13bc-000f-5001-9000-1f414d43364e	paid	1773993981	1773994117
141	1729	one	10	1	877080718	314f1390-000f-5001-8000-1bc78b3da632	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f1390-000f-5001-8000-1bc78b3da632	paid	1773993936	1773995198
143	1742	one	10	1	2018560243	314f14fb-000f-5001-8000-12c5373ed206	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f14fb-000f-5001-8000-12c5373ed206	paid	1773994299	1773994437
144	1749	one	10	1	646448570	314f1655-000f-5001-9000-144e63b25e8b	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f1655-000f-5001-9000-144e63b25e8b	paid	1773994645	1773994653
145	1761	one	10	1	686782813	314f16c7-000f-5000-b000-1a73b89def66	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f16c7-000f-5000-b000-1a73b89def66	pending	1773994759	\N
147	1752	one	10	1	599576469	314f1895-000f-5001-9000-1b7c804d3836	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f1895-000f-5001-9000-1b7c804d3836	paid	1773995221	1773995260
148	11	one	10	1	8340058151	314f1b4f-000f-5000-b000-1d273e2a741b	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f1b4f-000f-5000-b000-1d273e2a741b	paid	1773995919	1773995967
146	1751	one	10	1	1356844692	314f17bc-000f-5001-9000-180ea92b45e4	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f17bc-000f-5001-9000-180ea92b45e4	paid	1773995005	1773996752
149	11	one	0	1	\N	\N	\N	paid	1774002799	1774002799
150	1798	one	10	1	628629925	314f3ed4-000f-5001-9000-1328c8e34746	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f3ed4-000f-5001-9000-1328c8e34746	paid	1774005012	1774005443
151	1813	one	10	1	742792937	314f532d-000f-5000-8000-1bc8044bc195	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f532d-000f-5000-8000-1bc8044bc195	paid	1774010221	1774010280
152	11	one	10	1	558396308	314f6511-000f-5001-8000-1c90f0a7bb6c	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f6511-000f-5001-8000-1c90f0a7bb6c	cancelled	1774014801	\N
153	11	one	30	3	558396308	314f652c-000f-5000-b000-182d4be6e1cc	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f652c-000f-5000-b000-182d4be6e1cc	cancelled	1774014828	\N
154	1638	one	0	1	\N	\N	\N	paid	1774015369	1774015369
155	1843	one	10	1	983607854	314f6a1e-000f-5001-8000-10c6fd3ddaff	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f6a1e-000f-5001-8000-10c6fd3ddaff	pending	1774016095	\N
156	1713	five	75	3	5888026625	314f6b0a-000f-5000-b000-1fb2a3901e01	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f6b0a-000f-5000-b000-1fb2a3901e01	paid	1774016330	1774016374
157	1861	one	10	1	1987030973	314f77f5-000f-5001-8000-16a031af6046	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f77f5-000f-5001-8000-16a031af6046	paid	1774019637	1774019689
158	1867	five	300	12	652916763	314f7a0e-000f-5001-8000-124b17fa5ba9	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f7a0e-000f-5001-8000-124b17fa5ba9	paid	1774020174	1774020216
159	1874	one	10	1	621754429	314f8929-000f-5000-b000-1b5f69feddb9	https://yoomoney.ru/checkout/payments/v2/contract?orderId=314f8929-000f-5000-b000-1b5f69feddb9	paid	1774024041	1774024090
160	1882	one	120	12	816537333	31505f36-000f-5000-b000-132e28c13dcc	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31505f36-000f-5000-b000-132e28c13dcc	paid	1774078838	1774078929
161	11	one	0	1	\N	\N	\N	paid	1774082746	1774082746
162	1897	one	10	1	878142505	31507d1d-000f-5000-b000-1b67010efaf7	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31507d1d-000f-5000-b000-1b67010efaf7	paid	1774086493	1774086574
163	1903	five	75	3	366906750	31508530-000f-5000-b000-11307a43c9b9	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31508530-000f-5000-b000-11307a43c9b9	paid	1774088560	1774088618
164	1910	one	10	1	5157451253	3150ba73-000f-5000-b000-1878ee6bfdc8	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3150ba73-000f-5000-b000-1878ee6bfdc8	paid	1774102196	1774102667
165	1713	fifteen	50	1	5888026625	3150d792-000f-5000-b000-1ad998331e53	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3150d792-000f-5000-b000-1ad998331e53	paid	1774109650	1774109680
166	1897	five	25	1	878142505	3150f951-000f-5001-9000-17e3385620bb	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3150f951-000f-5001-9000-17e3385620bb	paid	1774118289	1774118319
167	1938	five	75	3	936367944	315126e6-000f-5000-8000-15b1c79a1c6a	https://yoomoney.ru/checkout/payments/v2/contract?orderId=315126e6-000f-5000-8000-15b1c79a1c6a	paid	1774129959	1774129998
168	1952	fifteen	150	3	1076136406	31519512-000f-5000-b000-1add5e230c43	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31519512-000f-5000-b000-1add5e230c43	paid	1774158162	1774158233
169	1203	one	30	3	459584886	3152351f-000f-5000-b000-1a5e4984932d	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3152351f-000f-5000-b000-1a5e4984932d	paid	1774199135	1774199161
171	1986	one	10	1	5135597375	3153043b-000f-5000-8000-1ab6d9322ffd	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3153043b-000f-5000-8000-1ab6d9322ffd	paid	1774252155	1774252226
172	1997	one	10	1	267983932	3153072b-000f-5001-8000-196939d731c9	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3153072b-000f-5001-8000-196939d731c9	paid	1774252907	1774253093
170	1556	one	10	1	2019379594	3152f727-000f-5001-8000-1f9783986b07	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3152f727-000f-5001-8000-1f9783986b07	paid	1774248807	1774257938
173	11	one	0	1	\N	\N	\N	paid	1774342340	1774342340
174	2043	one	60	6	1253811031	31547365-000f-5001-9000-1c5216a18d73	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31547365-000f-5001-9000-1c5216a18d73	paid	1774346149	1774346162
175	1713	one	0	1	\N	\N	\N	paid	1774350470	1774350470
176	382	one	0	1	\N	\N	\N	paid	1774350621	1774350621
177	767	one	0	1	\N	\N	\N	paid	1774352039	1774352039
178	775	one	0	1	\N	\N	\N	paid	1774352089	1774352089
179	2070	five	25	1	891958199	31549d08-000f-5001-9000-178f6f09b118	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31549d08-000f-5001-9000-178f6f09b118	pending	1774356808	\N
180	2070	five	25	1	891958199	31549d09-000f-5001-9000-1dcc6ca0fc24	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31549d09-000f-5001-9000-1dcc6ca0fc24	pending	1774356809	\N
181	1938	one	30	3	352469442	3154d9de-000f-5001-8000-19a71608a678	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3154d9de-000f-5001-8000-19a71608a678	paid	1774372382	1774372416
182	2098	one	30	3	1246575365	3154fc15-000f-5001-8000-169e26e81c3e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3154fc15-000f-5001-8000-169e26e81c3e	paid	1774381141	1774381368
183	11	one	10	1	558396308	31559e36-000f-5000-8000-1bc78675662a	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31559e36-000f-5000-8000-1bc78675662a	pending	1774422646	\N
184	11	one	10	1	558396308	3155df7a-000f-5000-b000-15d7e73783e7	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3155df7a-000f-5000-b000-15d7e73783e7	cancelled	1774439354	\N
185	11	one	10	1	558396308	3155dfc7-000f-5001-8000-14ba9930e35f	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3155dfc7-000f-5001-8000-14ba9930e35f	cancelled	1774439432	\N
200	11	one	0	1	\N	\N	\N	paid	1774597384	1774597384
186	2142	one	30	3	1904248886	31560a2a-000f-5001-8000-13e7963c4363	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31560a2a-000f-5001-8000-13e7963c4363	paid	1774450282	1774450335
187	11	one	0	1	\N	\N	\N	paid	1774450468	1774450468
188	2159	one	120	12	801994452	31562695-000f-5001-8000-14c42fce755e	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31562695-000f-5001-8000-14c42fce755e	paid	1774457557	1774457850
189	11	one	0	1	\N	\N	\N	paid	1774468725	1774468725
190	2176	one	30	3	2107029852	3156bde2-000f-5001-9000-14ad230766b1	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3156bde2-000f-5001-9000-14ad230766b1	paid	1774496290	1774496378
191	2188	five	75	3	931533618	31573d03-000f-5000-b000-1011513a3bff	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31573d03-000f-5000-b000-1011513a3bff	paid	1774528835	1774528886
192	2203	one	10	1	5162190458	31574dd1-000f-5000-8000-177a4fcf3238	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31574dd1-000f-5000-8000-177a4fcf3238	paid	1774533137	1774533146
193	11	one	0	1	\N	\N	\N	paid	1774533522	1774533522
194	1143	one	10	1	1076638199	31575d79-000f-5001-9000-14c979f314c1	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31575d79-000f-5001-9000-14c979f314c1	paid	1774537145	1774537203
195	296	one	10	1	853700754	315765d0-000f-5000-b000-15a2ee596e58	https://yoomoney.ru/checkout/payments/v2/contract?orderId=315765d0-000f-5000-b000-15a2ee596e58	paid	1774539280	1774539290
196	11	one	0	1	\N	\N	\N	paid	1774543523	1774543523
197	1149	one	10	1	737412186	31577c16-000f-5001-9000-13679b7d90e3	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31577c16-000f-5001-9000-13679b7d90e3	paid	1774544983	1774545022
198	1154	one	10	1	861362028	3157848b-000f-5001-9000-1b9b42e952d5	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3157848b-000f-5001-9000-1b9b42e952d5	paid	1774547147	1774547186
199	1462	one	10	1	5469749689	3157a532-000f-5001-9000-1d178e78fea7	https://yoomoney.ru/checkout/payments/v2/contract?orderId=3157a532-000f-5001-9000-1d178e78fea7	cancelled	1774555506	\N
201	1	five	25	1	1924535035	31585396-000f-5000-b000-1e45a5ae6679	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31585396-000f-5000-b000-1e45a5ae6679	pending	1774600150	\N
202	1395	five	300	12	275448300	31587a05-000f-5000-b000-17f0b765d000	https://yoomoney.ru/checkout/payments/v2/contract?orderId=31587a05-000f-5000-b000-17f0b765d000	paid	1774609990	1774610062
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.plans (code, title, devices_count, price_rub, duration_days) FROM stdin;
one	1 ссылка (1 устройство)	1	10	30
five	5 ссылок (5 устройств)	5	25	30
fifteen	15 ссылок (15 устройств)	15	50	30
\.


--
-- Data for Name: proxy_delivery_logs; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.proxy_delivery_logs (id, proxy_link_id, user_id, tg_user_id, user_label, subscription_id, device_number, delivery_source, proxy_url, delivered_at) FROM stdin;
559	229	11	558396308	Temich55/558396308	101	1	purchase	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774597384
560	106	1	1924535035	vovaww/1924535035	48	1	my_links	https://t.me/socks?server=130.193.41.234&port=30008&user=u30008&pass=3HzQkXkQjPs	1774599843
561	107	1	1924535035	vovaww/1924535035	48	2	my_links	https://t.me/socks?server=130.193.41.234&port=30009&user=u30009&pass=j8RamzCjJ0g	1774599843
562	108	1	1924535035	vovaww/1924535035	48	3	my_links	https://t.me/socks?server=130.193.41.234&port=30010&user=u30010&pass=6Se4214ULic	1774599844
563	109	1	1924535035	vovaww/1924535035	48	4	my_links	https://t.me/socks?server=130.193.41.234&port=30011&user=u30011&pass=ZWEdtdfIBuQ	1774599844
564	110	1	1924535035	vovaww/1924535035	48	5	my_links	https://t.me/socks?server=130.193.41.234&port=30012&user=u30012&pass=rZAA3LxRFYM	1774599844
565	111	1	1924535035	vovaww/1924535035	48	6	my_links	https://t.me/socks?server=130.193.41.234&port=30013&user=u30013&pass=sMx_JuPvPSc	1774599844
566	112	1	1924535035	vovaww/1924535035	48	7	my_links	https://t.me/socks?server=130.193.41.234&port=30014&user=u30014&pass=ol0DY8MxLHg	1774599844
567	113	1	1924535035	vovaww/1924535035	48	8	my_links	https://t.me/socks?server=130.193.41.234&port=30015&user=u30015&pass=J-49r6H5HpY	1774599845
568	114	1	1924535035	vovaww/1924535035	48	9	my_links	https://t.me/socks?server=130.193.41.234&port=30016&user=u30016&pass=IdiO5yjiIsU	1774599845
569	115	1	1924535035	vovaww/1924535035	48	10	my_links	https://t.me/socks?server=130.193.41.234&port=30017&user=u30017&pass=b0UWzY84sBg	1774599845
570	116	1	1924535035	vovaww/1924535035	48	11	my_links	https://t.me/socks?server=130.193.41.234&port=30018&user=u30018&pass=TW8Mozd4gq8	1774599845
571	117	1	1924535035	vovaww/1924535035	48	12	my_links	https://t.me/socks?server=130.193.41.234&port=30019&user=u30019&pass=RFFkNPZ9ya4	1774599845
572	118	1	1924535035	vovaww/1924535035	48	13	my_links	https://t.me/socks?server=130.193.41.234&port=30020&user=u30020&pass=Jo-uUGhvAOM	1774599846
573	119	1	1924535035	vovaww/1924535035	48	14	my_links	https://t.me/socks?server=130.193.41.234&port=30021&user=u30021&pass=sXKpxdILPOU	1774599846
574	120	1	1924535035	vovaww/1924535035	48	15	my_links	https://t.me/socks?server=130.193.41.234&port=30022&user=u30022&pass=uTYiCaGXib0	1774599846
575	223	11	558396308	Temich55/558396308	95	1	my_links	https://t.me/socks?server=130.193.41.234&port=29913&user=u29913&pass=z9RVB70FLo4	1774599991
576	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774599991
577	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774599991
578	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774599991
579	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774599991
580	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774599991
581	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774599992
582	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774599992
583	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774599992
584	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774599992
585	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774599992
586	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774599993
587	210	2094	352469442	352469442	86	1	my_links	https://t.me/socks?server=130.193.41.234&port=30112&user=u30112&pass=wzX7b0ieWiQ	1774602533
588	223	11	558396308	Temich55/558396308	95	1	my_links	https://t.me/socks?server=130.193.41.234&port=29913&user=u29913&pass=z9RVB70FLo4	1774604313
589	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774604313
590	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774604313
591	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774604313
592	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774604314
593	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774604314
594	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774604314
595	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774604314
596	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774604314
597	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774604315
598	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774604315
599	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774604315
600	223	11	558396308	Temich55/558396308	95	1	my_links	https://t.me/socks?server=130.193.41.234&port=29913&user=u29913&pass=z9RVB70FLo4	1774609879
601	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774609879
602	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774609879
603	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774609879
604	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774609879
605	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774609879
606	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774609880
607	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774609880
608	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774609880
609	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774609880
610	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774609880
611	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774609881
612	230	1395	275448300	whenth3/275448300	102	1	purchase	https://t.me/socks?server=130.193.41.234&port=29921&user=u29921&pass=JrEsVIsgbrg	1774610063
613	231	1395	275448300	whenth3/275448300	102	2	purchase	https://t.me/socks?server=130.193.41.234&port=29922&user=u29922&pass=0lHqgaJvIws	1774610063
614	232	1395	275448300	whenth3/275448300	102	3	purchase	https://t.me/socks?server=130.193.41.234&port=29923&user=u29923&pass=EX_DGMO1_aE	1774610063
615	233	1395	275448300	whenth3/275448300	102	4	purchase	https://t.me/socks?server=130.193.41.234&port=29924&user=u29924&pass=Jsdm9yVhOow	1774610063
616	234	1395	275448300	whenth3/275448300	102	5	purchase	https://t.me/socks?server=130.193.41.234&port=29925&user=u29925&pass=_2oEmv8NxUM	1774610063
617	201	1986	5135597375	valeriaburia/5135597375	77	1	my_links	https://t.me/socks?server=130.193.41.234&port=30103&user=u30103&pass=9512gRHYp_o	1774629979
618	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774635885
619	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774635885
620	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774635885
621	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774635885
622	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774635885
623	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774635885
624	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774635886
625	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774635886
626	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774635886
627	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774635886
628	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774635886
629	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774640961
630	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774640961
631	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774640961
632	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774640961
633	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774640961
634	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774640961
635	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774640962
636	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774640962
637	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774640962
638	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774640962
639	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774640962
640	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774641384
641	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774641385
642	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774641385
643	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774641385
644	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774641385
645	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774641385
646	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774641385
647	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774641386
648	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774641386
649	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774641386
650	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774641386
651	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774644791
652	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774644791
653	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774644792
654	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774644792
655	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774644792
656	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774644792
657	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774644792
658	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774644792
659	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774644793
660	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774644793
661	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774644793
662	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774646850
663	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774646850
664	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774646851
665	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774646851
666	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774646851
667	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774646851
668	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774646851
669	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774646851
670	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774646852
671	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774646852
672	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774646852
673	229	11	558396308	Temich55/558396308	101	1	my_links	https://t.me/socks?server=130.193.41.234&port=29920&user=u29920&pass=RBwC6NMSLWE	1774648795
674	204	11	558396308	Temich55/558396308	80	1	my_links	https://t.me/socks?server=130.193.41.234&port=30106&user=u30106&pass=o8AKre7chkw	1774648795
675	226	11	558396308	Temich55/558396308	98	1	my_links	https://t.me/socks?server=130.193.41.234&port=29917&user=u29917&pass=UjBQXZ2M3Lw	1774648795
676	60	11	558396308	Temich55/558396308	34	1	my_links	https://t.me/socks?server=130.193.41.234&port=29962&user=u29962&pass=F2i99DlivlU	1774648796
677	61	11	558396308	Temich55/558396308	35	1	my_links	https://t.me/socks?server=130.193.41.234&port=29963&user=u29963&pass=zc0hbeg16HQ	1774648796
678	84	11	558396308	Temich55/558396308	40	1	my_links	https://t.me/socks?server=130.193.41.234&port=29986&user=u29986&pass=SO4oYQiIw8g	1774648796
679	87	11	558396308	Temich55/558396308	43	1	my_links	https://t.me/socks?server=130.193.41.234&port=29989&user=u29989&pass=3QpSqj_VOgA	1774648796
680	89	11	558396308	Temich55/558396308	45	1	my_links	https://t.me/socks?server=130.193.41.234&port=29991&user=u29991&pass=DpnzRGWSpkY	1774648796
681	135	11	558396308	Temich55/558396308	59	1	my_links	https://t.me/socks?server=130.193.41.234&port=30037&user=u30037&pass=k42iBoH_2Ww	1774648796
682	152	11	558396308	Temich55/558396308	68	1	my_links	https://t.me/socks?server=130.193.41.234&port=30054&user=u30054&pass=eJqLS9Z2hqs	1774648797
683	213	11	558396308	Temich55/558396308	89	1	my_links	https://t.me/socks?server=130.193.41.234&port=29905&user=u29905&pass=MWwLbBJvJJg	1774648797
\.


--
-- Data for Name: proxy_links; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.proxy_links (id, subscription_id, user_id, device_number, token, link, status, created_at, expires_at) FROM stdin;
229	101	11	1	hH-nmadGgF85gDGc9DQqnz1V	socks5://u29920:RBwC6NMSLWE@130.193.41.234:29920	active	1774597384	1774683784
230	102	1395	1	1gdBtVP1Mj_3x3I_tzJgVeFQ	socks5://u29921:JrEsVIsgbrg@130.193.41.234:29921	active	1774610062	1805714062
231	102	1395	2	vRfkCmw2e5TdtF5mMOHqu6Np	socks5://u29922:0lHqgaJvIws@130.193.41.234:29922	active	1774610062	1805714062
232	102	1395	3	jnyLK_lataJmkraq5DtApasl	socks5://u29923:EX_DGMO1_aE@130.193.41.234:29923	active	1774610062	1805714062
233	102	1395	4	mVB3u4YY6uAp1LjqWltPs7hD	socks5://u29924:Jsdm9yVhOow@130.193.41.234:29924	active	1774610062	1805714062
234	102	1395	5	knxiQN-oZ92Mi9Wafj_lbtIx	socks5://u29925:_2oEmv8NxUM@130.193.41.234:29925	active	1774610062	1805714062
33	25	1195	1	0VI6W1TyMA8TtbpS5TdrEPhE	socks5://u29936:BKuOmxhtA8w@130.193.41.234:29936	active	1771948492	1779724492
35	27	1211	1	oe4Qc-WZBi_K-q5OqQB6T2FY	socks5://u29938:G0qIbmR4LZg@130.193.41.234:29938	active	1771949566	1780589566
13	9	11	1	xfmsyVf7VBrElkpUUAC3g_8T	socks5://u29916:GtZ3akIJhAI@130.193.41.234:29916	expired	1771934483	1772020883
38	30	1254	1	BD4xc4Gzhh-dm9teMsagzhfm	socks5://u29916:GtZ3akIJhAI@130.193.41.234:29916	active	1772022156	1777206156
39	31	1350	1	G5Y1I4eUj0miOsIKcsZeJrk7	socks5://u29941:t0s3X5HbdC8@130.193.41.234:29941	active	1772122264	1803226264
40	31	1350	2	5Nd-DVHbC_efj7pFfy_TowI-	socks5://u29942:4SRbe7WToEg@130.193.41.234:29942	active	1772122264	1803226264
41	31	1350	3	J1YsDXLx5FUQqpU1t7xflc_c	socks5://u29943:8KFLysn7Y34@130.193.41.234:29943	active	1772122264	1803226264
42	31	1350	4	8TFAUD6EK5D8GPegQXyAqyqq	socks5://u29944:Z7YUQrtpSOY@130.193.41.234:29944	active	1772122264	1803226264
43	31	1350	5	aW0lV7CzN4hy388_BHG0Vvug	socks5://u29945:w9HX0UKvkWk@130.193.41.234:29945	active	1772122264	1803226264
44	32	1337	1	nEjIIMK-e8p8bKGGxNoaaMy_	socks5://u29946:zxfn7GjrYuI@130.193.41.234:29946	active	1772174015	1803278015
45	32	1337	2	cAO7vpUpc1Azd6TyCrh0QeTN	socks5://u29947:ITDwe5Yq57Y@130.193.41.234:29947	active	1772174015	1803278015
46	32	1337	3	zVrK3C1Yp9nrmQ5MTtc7PYd6	socks5://u29948:2u3XKAcWQR4@130.193.41.234:29948	active	1772174015	1803278015
47	32	1337	4	A8CpW-BMCpKNPKyaKsYTe_V6	socks5://u29949:TWK4T1CMawA@130.193.41.234:29949	active	1772174015	1803278015
48	32	1337	5	X8bsTZ1S-VLPcVnaHX2SkezN	socks5://u29950:EzcjaZW1Wzc@130.193.41.234:29950	active	1772174015	1803278015
49	32	1337	6	4NAu9gLxq2dgMeCa2Illcb5_	socks5://u29951:tPEz3X8b_0A@130.193.41.234:29951	active	1772174015	1803278015
50	32	1337	7	7BcrVdz8ej-5E3wuY0vJfYwg	socks5://u29952:9DvTIAfA1kk@130.193.41.234:29952	active	1772174015	1803278015
51	32	1337	8	9LajmtBGiEg2IHjLrpdUSiI5	socks5://u29953:G14cNJqB6q4@130.193.41.234:29953	active	1772174015	1803278015
52	32	1337	9	InvlKvOoiXVMM5DMvkrUCVfy	socks5://u29954:xTf9NaIR234@130.193.41.234:29954	active	1772174015	1803278015
2	2	11	1	CjdVGs6DYKtq2JJUX42DHyK5	socks5://u29905:MWwLbBJvJJg@130.193.41.234:29905	expired	1771857251	1774449251
3	3	11	1	rJ1LmJzVvg5o96aVQ3UHtyr3	socks5://u29906:gAyH-Kwiw3c@130.193.41.234:29906	expired	1771864096	1774456096
4	4	11	1	zIVBM7xmSvFTJlbgiZeQ2HvZ	socks5://u29907:rGM_vDzLihA@130.193.41.234:29907	expired	1771911418	1774503418
5	5	326	1	LRtM_Dmt4qWZEjhZ-5c1Pyx5	socks5://u29908:E6Xp1uOg-GY@130.193.41.234:29908	expired	1771912508	1774504508
6	6	11	1	MJxqNtf0_Wjlt5GMrtG8QyWM	socks5://u29909:Sh4_gGuE3L0@130.193.41.234:29909	expired	1771913545	1774505545
7	7	382	1	OrbsRqy-Bg_zvmpaee_PO213	socks5://u29910:rgO97TYpc20@130.193.41.234:29910	expired	1771924136	1774516136
12	8	393	1	S1iWjyz1LSI5tQQIH20Co8qs	socks5://u29915:ukg4I07dtK8@130.193.41.234:29915	expired	1771929625	1774521625
14	10	11	1	wPosUW4C5KR1aPa0lKpk0k3r	socks5://u29917:UjBQXZ2M3Lw@130.193.41.234:29917	expired	1771935522	1774527522
15	11	11	1	bwJJb95KYMzcu71FjOvEpS75	socks5://u29918:mDuBQK9r_40@130.193.41.234:29918	expired	1771935875	1774527875
16	12	11	1	iUuAMFrFCzmWyqsD-8WJ7cUQ	socks5://u29919:Taat2PvdizA@130.193.41.234:29919	expired	1771936660	1774528660
17	13	11	1	NdK0TqfgD4GqYwAGsKvWwevM	socks5://u29920:RBwC6NMSLWE@130.193.41.234:29920	expired	1771936937	1774528937
18	14	326	1	R7G77KAevUze76ENGg2E--Dt	socks5://u29921:JrEsVIsgbrg@130.193.41.234:29921	expired	1771937059	1774529059
19	15	767	1	8rys4946sMuGRcQvKRHgaG2d	socks5://u29922:0lHqgaJvIws@130.193.41.234:29922	expired	1771938619	1774530619
20	16	776	1	85xJ7KTVhlYC3mJQrTm8iEEv	socks5://u29923:EX_DGMO1_aE@130.193.41.234:29923	expired	1771939346	1774531346
21	17	296	1	NiASaglU4ygNgnFxaLZbrsMc	socks5://u29924:Jsdm9yVhOow@130.193.41.234:29924	expired	1771943908	1774535908
22	18	1135	1	7gEwTodc1ihXcHIxQx16k2bE	socks5://u29925:_2oEmv8NxUM@130.193.41.234:29925	expired	1771944425	1774536425
23	18	1135	2	8moGznNEVrk4zLQabYCx4wbm	socks5://u29926:Pvbd3mbaTdU@130.193.41.234:29926	expired	1771944425	1774536425
24	18	1135	3	M6fkkiMHat_yGTWfZX897PGK	socks5://u29927:Ho0i-yzp-HE@130.193.41.234:29927	expired	1771944425	1774536425
25	18	1135	4	XcbcjBEYs7mmfdxOQlv0MKQI	socks5://u29928:OVuNC2WgH5w@130.193.41.234:29928	expired	1771944425	1774536425
27	19	1143	1	c6Qnk_DnUs9klU2YuDtzi4yu	socks5://u29930:MsRN5LSBA-s@130.193.41.234:29930	expired	1771944684	1774536684
28	20	1149	1	h9LIfTJOHoKSj7uR-F8KJc6S	socks5://u29931:P4bh2fr4LFg@130.193.41.234:29931	expired	1771944816	1774536816
29	21	1154	1	81vATa1fnuXgNf24lp4rAQS7	socks5://u29932:qKOgmxCbqhI@130.193.41.234:29932	expired	1771944830	1774536830
30	22	1161	1	CZItk9agYJI4yGGzZ903cDtJ	socks5://u29933:aRdYEZbQrwQ@130.193.41.234:29933	expired	1771945368	1774537368
31	23	1172	1	H9AZqkh13qACD_bAI4O5xwOS	socks5://u29934:jUEX4ExZ0NI@130.193.41.234:29934	expired	1771946596	1774538596
32	24	1181	1	NCd-H6FmufNG2VPCXeTKReZh	socks5://u29935:est2Z4Iiv0g@130.193.41.234:29935	expired	1771947390	1774539390
34	26	1203	1	lTTz2XTKLw0BaXBZllJxzFZy	socks5://u29937:YtwIKcCZNpk@130.193.41.234:29937	expired	1771948673	1774540673
36	28	1118	1	mkDghCOlbpqYi04pQ-E3QAAc	socks5://u29939:fkr1VXPOBHY@130.193.41.234:29939	expired	1771951955	1774543955
37	29	775	1	M22FVIxNW8QORmmxO20eZXaj	socks5://u29940:mW99XBcjL-E@130.193.41.234:29940	expired	1771957732	1774549732
53	32	1337	10	b1pZGiY9Iw84JrDPoR6QwiYY	socks5://u29955:AzLo7AuSiHM@130.193.41.234:29955	active	1772174015	1803278015
54	32	1337	11	ARdMOqr3zaCXuGmzxGNevh0Y	socks5://u29956:ATzuRXB7pp4@130.193.41.234:29956	active	1772174015	1803278015
55	32	1337	12	ubdqKmqlMQRBOdXII2gxtugO	socks5://u29957:0SvCZO3IDoI@130.193.41.234:29957	active	1772174015	1803278015
56	32	1337	13	cERKCihmoGhutXcN8-2WGCZb	socks5://u29958:eaB9-XX01rs@130.193.41.234:29958	active	1772174015	1803278015
57	32	1337	14	Z-_NxzQj-dlpuD_ZbQcZJop_	socks5://u29959:xnrUTBm5neA@130.193.41.234:29959	active	1772174015	1803278015
58	32	1337	15	t0kvE7JcU7AwRd7wa7_4Br8L	socks5://u29960:H00aqXPsIbo@130.193.41.234:29960	active	1772174015	1803278015
59	33	1389	1	8tmPgIfzU75OXEPLEqBWKpv2	socks5://u29961:0TZOfGcwLOY@130.193.41.234:29961	active	1772186027	1803290027
60	34	11	1	1OmWMbUPekqerRZ3xPCxsLIT	socks5://u29962:F2i99DlivlU@130.193.41.234:29962	active	1772367963	1858767963
61	35	11	1	QX312oexf4KasJKbWde0E99h	socks5://u29963:zc0hbeg16HQ@130.193.41.234:29963	active	1772368186	1858768186
62	36	1445	1	Eq-XnFv69j0jAtwdnq8_h5nC	socks5://u29964:PnGUC0IHn2w@130.193.41.234:29964	active	1772559044	1775151044
63	36	1445	2	mQooBE-ACS_XfFjCmMn9pJmJ	socks5://u29965:zILWBTBSo1U@130.193.41.234:29965	active	1772559044	1775151044
64	36	1445	3	pyzzTIVZFaXIOaa41wzIKyPA	socks5://u29966:0TNkaoJZSGY@130.193.41.234:29966	active	1772559044	1775151044
65	36	1445	4	SWpraq9VMUy9N3Hj6REiMKgF	socks5://u29967:PgFOaeB0Nsc@130.193.41.234:29967	active	1772559044	1775151044
66	36	1445	5	jznKyOx4SUN6DctPwJg1VxoS	socks5://u29968:Td-uhbBZF6s@130.193.41.234:29968	active	1772559044	1775151044
67	37	1453	1	MCzey-tHXMi1Vq9fnTrHUpd4	socks5://u29969:S_7bW84YCQk@130.193.41.234:29969	active	1772620692	1803724692
68	37	1453	2	_O_6dD6qmxiv-UxLzQj_dXnF	socks5://u29970:x1pREBnstPE@130.193.41.234:29970	active	1772620692	1803724692
69	37	1453	3	76w62NKyATJZSA-u4it1LCH0	socks5://u29971:Isp0ZHCVsx4@130.193.41.234:29971	active	1772620692	1803724692
70	37	1453	4	iacLMiZ90wpEmDiYlkCDDatq	socks5://u29972:UI3pYq-E6jc@130.193.41.234:29972	active	1772620692	1803724692
71	37	1453	5	vMLvAySYsodfgVcWlvWPTFT0	socks5://u29973:QpL_m5Mzd5I@130.193.41.234:29973	active	1772620692	1803724692
72	37	1453	6	753z4girFEB8TygdDm3c9_yP	socks5://u29974:Wtr707DzVn8@130.193.41.234:29974	active	1772620692	1803724692
73	37	1453	7	hkM4x9M5GHYyok-iaRdJ-as6	socks5://u29975:zFqal7ni3PE@130.193.41.234:29975	active	1772620692	1803724692
74	37	1453	8	vVo1UTJTbsjYg-5f7atTszeP	socks5://u29976:oGIljvMnneU@130.193.41.234:29976	active	1772620692	1803724692
75	37	1453	9	my3oVcDBOMCIWqKB3A1jSDuN	socks5://u29977:DYaF6NQPtJA@130.193.41.234:29977	active	1772620692	1803724692
76	37	1453	10	y3-3S4-afDaTqPZ0j6i7v5b6	socks5://u29978:vkZ2Ckx7O8g@130.193.41.234:29978	active	1772620692	1803724692
77	37	1453	11	Yj9VIQMbTQz5yU4eVeEh-cIq	socks5://u29979:wY6f7o8rx4g@130.193.41.234:29979	active	1772620692	1803724692
78	37	1453	12	CuBSW_8wXnyAzQ31Z8rIVIKI	socks5://u29980:MUHGZD2WxRc@130.193.41.234:29980	active	1772620692	1803724692
79	37	1453	13	OncgUpjQSNvaXS1jgRSbG65V	socks5://u29981:e0i9eS1HXss@130.193.41.234:29981	active	1772620692	1803724692
80	37	1453	14	g8uRj1Sn3rHDg7b5E9AUw5i4	socks5://u29982:wtgH-09dpL8@130.193.41.234:29982	active	1772620692	1803724692
81	37	1453	15	Z9yxayB45hRhhBWxJFP-RBwd	socks5://u29983:RDZLELFRA9k@130.193.41.234:29983	active	1772620692	1803724692
82	38	1230	1	3wGjZEzniBmQGwc_tt8zlafI	socks5://u29984:4eoeAHD0fRI@130.193.41.234:29984	active	1772951945	1804055945
83	39	1492	1	SWgPOgz_sBB7fwgUOO5soY2N	socks5://u29985:oQMU5xWJADE@130.193.41.234:29985	active	1773085430	1778269430
84	40	11	1	cW2Lq04mqA8Fk4EYf0e-bdcW	socks5://u29986:SO4oYQiIw8g@130.193.41.234:29986	active	1773580226	1859980226
85	41	1544	1	TOnyf-y-YnOMR3U_tX_ocvNs	socks5://u29987:A5n9IYuh-e0@130.193.41.234:29987	active	1773653698	1776245698
86	42	1568	1	C-Hpmy1OzlG5ush5672tuRDy	socks5://u29988:-yjjz3yyJCs@130.193.41.234:29988	active	1773659010	1776251010
87	43	11	1	3c08EL_lTvy2hwn3XvpPHo60	socks5://u29989:3QpSqj_VOgA@130.193.41.234:29989	active	1773659496	1860059496
88	44	1584	1	nVUaitHJid0vgj98Kn6xTXFP	socks5://u29990:ukufgR1KafI@130.193.41.234:29990	active	1773682724	1776274724
89	45	11	1	B3JJOYQzXs2oFdFOJKKWedTK	socks5://u29991:DpnzRGWSpkY@130.193.41.234:29991	active	1773817747	1860217747
90	46	1624	1	Tp1h4Om_hbR6M_DOJvr_DNU4	socks5://u29992:Ma53JIT3SmY@130.193.41.234:29992	active	1773838369	1804942369
91	46	1624	2	le2NOMdkmhZa5mKcTB0DmaQC	socks5://u29993:1QVMCirzSH0@130.193.41.234:29993	active	1773838369	1804942369
92	46	1624	3	TFZGyGo_iJ3gqXly0yPvVLDw	socks5://u29994:nnZyUnyyb1M@130.193.41.234:29994	active	1773838369	1804942369
93	46	1624	4	ksCY_S4Iccpm3ew2oaED_FQj	socks5://u29995:ls8dilOsVL8@130.193.41.234:29995	active	1773838369	1804942369
94	46	1624	5	ztAh4apj4KKr0N9pBSbjsU9Y	socks5://u29996:x85u8FmkxnQ@130.193.41.234:29996	active	1773838369	1804942369
95	46	1624	6	zc2c51sUWgGkVPfgaL0lj-vd	socks5://u29997:FGopS1BOP2Q@130.193.41.234:29997	active	1773838369	1804942369
96	46	1624	7	Zy7jCn0MPuJNJWMIk6PlJcbn	socks5://u29998:65LhEDzUQCU@130.193.41.234:29998	active	1773838369	1804942369
97	46	1624	8	mWBvNYd_tMVurLRCeLP4xJ0p	socks5://u29999:yHxvFfEgavE@130.193.41.234:29999	active	1773838369	1804942369
98	46	1624	9	lroit6jDNz5eNJNCSUnAIiWB	socks5://u30000:P82lrfZmZXU@130.193.41.234:30000	active	1773838369	1804942369
99	46	1624	10	6IX9MFtJbg_412GS4bMJOzhO	socks5://u30001:cOwNdQ-f3KM@130.193.41.234:30001	active	1773838369	1804942369
100	46	1624	11	wo8Defk9JUQ-xobU_7IGXS74	socks5://u30002:T2Psko3GeFk@130.193.41.234:30002	active	1773838369	1804942369
101	46	1624	12	CnfAcTHNkFkXo99kZADCLqJ8	socks5://u30003:ZjYBo9myaJs@130.193.41.234:30003	active	1773838369	1804942369
102	46	1624	13	p_R5mb1rjSYDoBOwEwjg80hT	socks5://u30004:c1CaqRQKjdY@130.193.41.234:30004	active	1773838369	1804942369
103	46	1624	14	3fZV1biB8TTIey0jRmZoTfyL	socks5://u30005:kcp8dnvSyC8@130.193.41.234:30005	active	1773838369	1804942369
104	46	1624	15	16oFeN-yLJfPFMskFRA346j0	socks5://u30006:sMAIye6yq1w@130.193.41.234:30006	active	1773838369	1804942369
105	47	1644	1	GgMdL2y-bMCGHlVeQQoKJV5r	socks5://u30007:E_dSDW4LK0E@130.193.41.234:30007	active	1773912486	1776504486
106	48	1	1	ukLBafe49lXnU_WLu7qVh8rQ	socks5://u30008:3HzQkXkQjPs@130.193.41.234:30008	active	1773916855	1784284855
107	48	1	2	fXkhqJrpttKpJxGashfY3mcR	socks5://u30009:j8RamzCjJ0g@130.193.41.234:30009	active	1773916855	1784284855
108	48	1	3	LbexuxoicI6G1Qwib-a3PBs6	socks5://u30010:6Se4214ULic@130.193.41.234:30010	active	1773916855	1784284855
109	48	1	4	AdzAaf_jl4T6R8UdvePMSdrD	socks5://u30011:ZWEdtdfIBuQ@130.193.41.234:30011	active	1773916855	1784284855
110	48	1	5	Ciqu4jN4YIcyLCfQIgQc6i6l	socks5://u30012:rZAA3LxRFYM@130.193.41.234:30012	active	1773916855	1784284855
111	48	1	6	BjUh6OXK6ZuyFB2bNu3TDVnW	socks5://u30013:sMx_JuPvPSc@130.193.41.234:30013	active	1773916855	1784284855
112	48	1	7	rlEB-r_JYqUjzFO-63cN8xzP	socks5://u30014:ol0DY8MxLHg@130.193.41.234:30014	active	1773916855	1784284855
113	48	1	8	G3vaapXKlIV_ccRVzI0JWbne	socks5://u30015:J-49r6H5HpY@130.193.41.234:30015	active	1773916855	1784284855
114	48	1	9	MSrr90aS2McDLfodAPpg0G7T	socks5://u30016:IdiO5yjiIsU@130.193.41.234:30016	active	1773916855	1784284855
115	48	1	10	C3Gk8I4dimmN4IBH2VkU7y-k	socks5://u30017:b0UWzY84sBg@130.193.41.234:30017	active	1773916855	1784284855
116	48	1	11	DXo_rPSIowvga8Qxbjb5joHj	socks5://u30018:TW8Mozd4gq8@130.193.41.234:30018	active	1773916855	1784284855
117	48	1	12	F08NRPloXQDjcWDjNREBUy-k	socks5://u30019:RFFkNPZ9ya4@130.193.41.234:30019	active	1773916855	1784284855
118	48	1	13	U4bdTb7hDe_oB0F_E5jZb-DN	socks5://u30020:Jo-uUGhvAOM@130.193.41.234:30020	active	1773916855	1784284855
119	48	1	14	zUYxv49d2WLE3y8n-qLBxJTr	socks5://u30021:sXKpxdILPOU@130.193.41.234:30021	active	1773916855	1784284855
120	48	1	15	7oDAOaLWWyI54MxnTIozadl5	socks5://u30022:uTYiCaGXib0@130.193.41.234:30022	active	1773916855	1784284855
121	49	1702	1	pewgbgp4igIz2rMp8O72T1Fc	socks5://u30023:1Bf3Sg9yYaU@130.193.41.234:30023	active	1773925424	1776517424
122	50	1713	1	Nzlt5FWqFKAPvkXiVrTugs0-	socks5://u30024:AumlGUMw6TA@130.193.41.234:30024	active	1773993738	1776585738
123	51	1714	1	B0U2ZCpRDHxdF2RY6gP0atvF	socks5://u30025:s5KVi_umS_c@130.193.41.234:30025	active	1773993751	1776585751
124	51	1714	2	R3uVLuhYmyssJyPjaWBuQKGq	socks5://u30026:nqOiIVX5-Xk@130.193.41.234:30026	active	1773993751	1776585751
125	51	1714	3	qjb8QA_vgsbw8v7H05IE80EA	socks5://u30027:x3xmP_ON9qM@130.193.41.234:30027	active	1773993751	1776585751
126	51	1714	4	tycA5j4pjcrX0QwoftbzOxJF	socks5://u30028:ZUt_06LSClA@130.193.41.234:30028	active	1773993751	1776585751
127	51	1714	5	UcY-hvjXZVnWvzM9pEm17tts	socks5://u30029:fckA_d3M3CI@130.193.41.234:30029	active	1773993751	1776585751
128	52	1734	1	tnD8JKZlon2aIh7qsfUMhoRi	socks5://u30030:5fdNQB70mL8@130.193.41.234:30030	active	1773994117	1776586117
129	53	1742	1	ZmAYBln21yFfM1PL0rf1DEMz	socks5://u30031:qTEuBPsv3Bc@130.193.41.234:30031	active	1773994437	1776586437
130	54	1749	1	5YZlyYV8sLOqzRZO1DnEIUDl	socks5://u30032:VZeSh4OXE20@130.193.41.234:30032	active	1773994653	1776586653
131	55	1729	1	i6hs2P7pAXbs6sI8QARSOd54	socks5://u30033:UiTeK7EfqrQ@130.193.41.234:30033	active	1773995198	1776587198
132	56	1752	1	A9d9TAa5-1qy2C4akJZ6GeWI	socks5://u30034:SKIWZeD_jEQ@130.193.41.234:30034	active	1773995260	1776587260
133	57	1788	1	R38KAh333OqhnplD-1VyEX1h	socks5://u30035:JFOMDBBPrTg@130.193.41.234:30035	active	1773995967	1776587967
134	58	1751	1	aE8f-jNFhcRfhMCVQpL4CfTO	socks5://u30036:cBNokpFWZiI@130.193.41.234:30036	active	1773996752	1776588752
135	59	11	1	lYqU7ld7ze5NMn4-ey8tm5M0	socks5://u30037:k42iBoH_2Ww@130.193.41.234:30037	active	1774002799	1860402799
136	60	1798	1	b_FAb3QgyMj8C9EAp7JJMVrt	socks5://u30038:h3eFYaW1GOI@130.193.41.234:30038	active	1774005443	1776597443
137	61	1813	1	sig3ZuSCa5JsSHOMhwZwYw8k	socks5://u30039:1RqXtqZGQn0@130.193.41.234:30039	active	1774010280	1776602280
138	62	1638	1	n-Thg3OQPHKHK578oBp1jTK5	socks5://u30040:taC0Mus3wM0@130.193.41.234:30040	active	1774015369	1779199369
139	63	1713	1	P9r8JiCAzzHERoUXCDseXrrC	socks5://u30041:oqUx_L1BRBA@130.193.41.234:30041	active	1774016374	1781792374
140	63	1713	2	SWHqTV-X5cujBCpqBAXHcNKW	socks5://u30042:GENftTMm4fo@130.193.41.234:30042	active	1774016374	1781792374
141	63	1713	3	pduEwFl69hOj-5s_rN7wvMf_	socks5://u30043:j2xvSzVLs-g@130.193.41.234:30043	active	1774016374	1781792374
142	63	1713	4	t4kHmFUP4InwNqb-jX2oMWYu	socks5://u30044:z50EemoyeGs@130.193.41.234:30044	active	1774016374	1781792374
143	63	1713	5	Vl-NRdyM_vC2sl8agHDLPt8G	socks5://u30045:ckB1rKr0ZSk@130.193.41.234:30045	active	1774016374	1781792374
144	64	1861	1	JKFXRoaDFzlaxFLmSXFQm08Z	socks5://u30046:mp1z50R_8NU@130.193.41.234:30046	active	1774019689	1776611689
145	65	1867	1	AvdIo6bsiy9yBW4D2XJnNHCX	socks5://u30047:7JT0PdZIl-g@130.193.41.234:30047	active	1774020216	1805124216
146	65	1867	2	xPfSYwGQeSz0CFFasozyDdzs	socks5://u30048:3SNCc6zq-fQ@130.193.41.234:30048	active	1774020216	1805124216
147	65	1867	3	rwGrrnu1MmhJKPONiFF5VQEc	socks5://u30049:a4_ZJUnpsbY@130.193.41.234:30049	active	1774020216	1805124216
148	65	1867	4	ihNLVPgzDpsJFF4PUuwguMp5	socks5://u30050:nEllXEgh1aM@130.193.41.234:30050	active	1774020216	1805124216
149	65	1867	5	md4tVM92Ia8c2AopwRSh8HjU	socks5://u30051:GCUopnxmVFQ@130.193.41.234:30051	active	1774020216	1805124216
150	66	1874	1	25RJXoCvVwmy7Ux0iga6Ptea	socks5://u30052:7Py5Bs4PXEE@130.193.41.234:30052	active	1774024090	1776616090
151	67	1882	1	L2fVV6sv_wJJ23ELCsp0_tTx	socks5://u30053:Llx2_tOy4bc@130.193.41.234:30053	active	1774078929	1805182929
152	68	11	1	SBLYqCRH3_F7eGqNmIdt4qDT	socks5://u30054:eJqLS9Z2hqs@130.193.41.234:30054	active	1774082746	1860482746
153	69	1897	1	fZMD8n-ufeOIiyrgl8H4Rh28	socks5://u30055:s1VP82ZshvM@130.193.41.234:30055	active	1774086574	1776678574
154	70	1903	1	87fmuHRV3ld2zt2rLbmS1U3-	socks5://u30056:TxuWvASRHv8@130.193.41.234:30056	active	1774088618	1781864618
155	70	1903	2	MVwtBaMudpYns3SsTXh6pb50	socks5://u30057:vMY3Q84-N40@130.193.41.234:30057	active	1774088618	1781864618
156	70	1903	3	RrH8ThV7AhHO3DS9GSbMYdCB	socks5://u30058:nCmMX8foP2k@130.193.41.234:30058	active	1774088618	1781864618
157	70	1903	4	6pz14LZjpEkUi5wZEaJvz79E	socks5://u30059:y6hLTBwdxS4@130.193.41.234:30059	active	1774088618	1781864618
158	70	1903	5	oBPTATP-TnIKIoJXiqphObSI	socks5://u30060:_hS_ctxWAl4@130.193.41.234:30060	active	1774088618	1781864618
159	71	1910	1	lbJaQh3EHRx1Q4lm41jLgZSU	socks5://u30061:GhROAAy19OQ@130.193.41.234:30061	active	1774102667	1776694667
160	72	1713	1	ieW_9VAKpmTJ5GJ60G2rQTQt	socks5://u30062:tt16tU585UY@130.193.41.234:30062	active	1774109680	1776701680
161	72	1713	2	s4ynHdpeHOX_5Bc31jz89UPT	socks5://u30063:GXwY4Prd8Js@130.193.41.234:30063	active	1774109680	1776701680
162	72	1713	3	zLG6ZZCp359sTADscF30CNwo	socks5://u30064:D4b-rVZVqBc@130.193.41.234:30064	active	1774109680	1776701680
163	72	1713	4	O1QiV4SGpp_2UefpvFzEIHO5	socks5://u30065:pSdHL3xwN1U@130.193.41.234:30065	active	1774109680	1776701680
164	72	1713	5	lckNuS-6gbyzY2ZbU0yxeox2	socks5://u30066:o2hDVfY2Smw@130.193.41.234:30066	active	1774109680	1776701680
165	72	1713	6	fQdGmkAcduJ7saTwDjqII9If	socks5://u30067:xEpfOM--xgY@130.193.41.234:30067	active	1774109680	1776701680
166	72	1713	7	46Bo9ZxEkrVMYtL5rDZyNYw_	socks5://u30068:LYai0vsitBc@130.193.41.234:30068	active	1774109680	1776701680
167	72	1713	8	KFTo_HbM_UbIQ3bMdLUGN00d	socks5://u30069:7s1MU0jLAHg@130.193.41.234:30069	active	1774109680	1776701680
168	72	1713	9	TSA56veJqajQ8Nimlw0GV7B5	socks5://u30070:zTHAnslyx_Q@130.193.41.234:30070	active	1774109680	1776701680
169	72	1713	10	6EodU6Ffr6aRicWNRX9_72mb	socks5://u30071:j7Xr8ElZtZ4@130.193.41.234:30071	active	1774109680	1776701680
170	72	1713	11	ne-OylXML9boBBSYb_kNzPLL	socks5://u30072:xheDMZ_Pv0Q@130.193.41.234:30072	active	1774109680	1776701680
171	72	1713	12	IKppUrh1lzY40bDRXLP4FWJI	socks5://u30073:6YiKFX-ltbU@130.193.41.234:30073	active	1774109680	1776701680
172	72	1713	13	eZy7KcftLSI9sxoTg9JMm6ke	socks5://u30074:7fGZUw6WKwM@130.193.41.234:30074	active	1774109680	1776701680
173	72	1713	14	ERxgmhevKyFsnE1OHGQbmGeH	socks5://u30075:mxFLQr0sPwE@130.193.41.234:30075	active	1774109680	1776701680
174	72	1713	15	zveb_9S1mXXMsMAA32eWY1r6	socks5://u30076:UYtMz9gqkPA@130.193.41.234:30076	active	1774109680	1776701680
175	73	1897	1	-k4C2N_bCc9wb9geY1OAlfGf	socks5://u30077:-KUZ-pYu_XY@130.193.41.234:30077	active	1774118319	1776710319
176	73	1897	2	CjqSsKHs0V5ZQmp16JTE9ehs	socks5://u30078:LF6mRpVvbJw@130.193.41.234:30078	active	1774118319	1776710319
177	73	1897	3	7UKeMndovPdpNhyatS-wuYIR	socks5://u30079:kVUjk4zGNH4@130.193.41.234:30079	active	1774118319	1776710319
178	73	1897	4	VCFt7f14rEDhnJl6S5gVSD66	socks5://u30080:RKtDYkvSgH8@130.193.41.234:30080	active	1774118319	1776710319
179	73	1897	5	GjryOVQ7jVpqJPILxLKRjR2a	socks5://u30081:qfQtRSgs2D8@130.193.41.234:30081	active	1774118319	1776710319
180	74	1938	1	hAg8qi88sJES6FXpVB2AbtKK	socks5://u30082:tAwOERI371I@130.193.41.234:30082	active	1774129998	1781905998
181	74	1938	2	tdimdRFjLcZC0ENR_VjEWr4b	socks5://u30083:SxI9Nml9hvE@130.193.41.234:30083	active	1774129998	1781905998
182	74	1938	3	ZW9NF72BnaZcfz9Sigm26UmA	socks5://u30084:ZVSX2DovZU8@130.193.41.234:30084	active	1774129998	1781905998
183	74	1938	4	xuBH60X_SvAfa4SxHfvimwrq	socks5://u30085:WObHROf5iu4@130.193.41.234:30085	active	1774129998	1781905998
184	74	1938	5	xHSckv6g6uSnaulREoHZycI1	socks5://u30086:FcLZdROq06w@130.193.41.234:30086	active	1774129998	1781905998
185	75	1952	1	o22faCWx0wjp7Zn7SgGuD78M	socks5://u30087:v7VZ1dBZwMs@130.193.41.234:30087	active	1774158233	1781934233
186	75	1952	2	MzatpqUKrex28WI3E-ZMYXJG	socks5://u30088:v3dWbSU0_cg@130.193.41.234:30088	active	1774158233	1781934233
187	75	1952	3	ScGKeJTlADuyCdQgegzsftP_	socks5://u30089:tLeDZWUidcc@130.193.41.234:30089	active	1774158233	1781934233
188	75	1952	4	FnVv1RTz1YbhJTcVG87lFhzL	socks5://u30090:qaHqlP0PwcA@130.193.41.234:30090	active	1774158233	1781934233
189	75	1952	5	eO8UzICQfW-n4LiOynh3urbq	socks5://u30091:xflu8UveW60@130.193.41.234:30091	active	1774158233	1781934233
190	75	1952	6	GPyoE12wAdwvY9yKYtcwsHxY	socks5://u30092:aQrNcTftMhY@130.193.41.234:30092	active	1774158233	1781934233
191	75	1952	7	cIgr5_FZHCnLViYhAgCwR-Ot	socks5://u30093:Wt9J8ukzK3Y@130.193.41.234:30093	active	1774158233	1781934233
192	75	1952	8	3ZjEgM4SM3kkezyeqKsxZN_n	socks5://u30094:mHIfnrmuDVE@130.193.41.234:30094	active	1774158233	1781934233
193	75	1952	9	fQGgxmBWPdB3cxzDEJCwQZwX	socks5://u30095:Ukpm2EyVLgU@130.193.41.234:30095	active	1774158233	1781934233
194	75	1952	10	ZU7otvR3L2sSmNjMtBUeDVaE	socks5://u30096:n4qGZgOMCEw@130.193.41.234:30096	active	1774158233	1781934233
195	75	1952	11	iVq_VOuxQ7QuHgExzVzjDKE2	socks5://u30097:cLqUYQVtxdg@130.193.41.234:30097	active	1774158233	1781934233
196	75	1952	12	LnB13EsO3dccmEgkO0mTFqDt	socks5://u30098:ucocP1qbWkE@130.193.41.234:30098	active	1774158233	1781934233
197	75	1952	13	HGjaBLFooAJO1gamniHG_wu4	socks5://u30099:RsKRxFNMwAQ@130.193.41.234:30099	active	1774158233	1781934233
198	75	1952	14	N38t4nu9rn0cMNwDdNt0dwpn	socks5://u30100:XQpN5rUG7Jo@130.193.41.234:30100	active	1774158233	1781934233
199	75	1952	15	oNgcg4b3YXVMqZUOUfsVrR9x	socks5://u30101:lhoalXvpvYY@130.193.41.234:30101	active	1774158233	1781934233
200	76	1203	1	ff1CeP6UF4ylMbKmtwUrfXmL	socks5://u30102:NTYM0I_A7Z4@130.193.41.234:30102	active	1774199161	1781975161
201	77	1986	1	M8JGOt1D5fFvghQTZQHDccaB	socks5://u30103:9512gRHYp_o@130.193.41.234:30103	active	1774252226	1776844226
202	78	1997	1	fgO6iqnLvHLd72pLp98AjawH	socks5://u30104:1LSGOZyAz2c@130.193.41.234:30104	active	1774253093	1776845093
203	79	1556	1	4J_DBS48kwF41n3Rouu_xN2k	socks5://u30105:eYSBXAWYKz0@130.193.41.234:30105	active	1774257938	1776849938
204	80	11	1	8hSbRFW9FvD_DenSDvHDtMNJ	socks5://u30106:o8AKre7chkw@130.193.41.234:30106	active	1774342340	1774947140
205	81	2043	1	mh2KevU4Ioz_6tP9ac6zWZKh	socks5://u30107:PIh2CCpw9ks@130.193.41.234:30107	active	1774346162	1789898162
206	82	1713	1	WcnKKmvRxYp0N3_9_TbKm4hb	socks5://u30108:faCFGB_cu2Y@130.193.41.234:30108	active	1774350470	1776942470
207	83	382	1	ZW-pdym3KN3Jy2wfqxSGajTM	socks5://u30109:nodvovA8Wic@130.193.41.234:30109	active	1774350621	1776942621
208	84	767	1	okc-ht4bNNclC1-UL6VRgKm0	socks5://u30110:ry_0wBl1Bq8@130.193.41.234:30110	active	1774352039	1776944039
209	85	775	1	rBlK68HThdxomCHEB5scYBm-	socks5://u30111:VpEx2wVDJrE@130.193.41.234:30111	active	1774352089	1776944089
210	86	2094	1	wjbvcHlHSu1rB_7XdmgeWMeP	socks5://u30112:wzX7b0ieWiQ@130.193.41.234:30112	active	1774372416	1782148416
211	87	2098	1	TCmL3ETYVrWcrQpTL73pDJKz	socks5://u30113:NSecJSi74uk@130.193.41.234:30113	active	1774381368	1782157368
1	1	1	1	EEMhVGtWiyoRmhXggnpMffcp	socks5://u29904:ozpQjefbpfE@130.193.41.234:29904	expired	1771857147	1774449147
212	88	2142	1	O0gsd_W0Yl5t5q6QYz5YwFF8	socks5://u29904:ozpQjefbpfE@130.193.41.234:29904	active	1774450335	1782226335
213	89	11	1	TioWhc0q2u0VJi6Dom9R4nG0	socks5://u29905:MWwLbBJvJJg@130.193.41.234:29905	active	1774450468	1860850468
214	90	2159	1	cO3yfoCF7BUW2BWXKVtjqZjg	socks5://u29906:gAyH-Kwiw3c@130.193.41.234:29906	active	1774457850	1805561850
216	92	2176	1	L9z6eJPsfDPSqy1c2kIe5AlT	socks5://u30115:oGNsPaPapQ4@130.193.41.234:30115	active	1774496378	1782272378
8	7	382	2	-xrwSu_DK566SY4iSt1PqLyg	socks5://u29911:e57n3z7jI6A@130.193.41.234:29911	expired	1771924136	1774516136
9	7	382	3	iMqBcEEb4It8Wq0YyfFZvGuf	socks5://u29912:X0Ihtinjroo@130.193.41.234:29912	expired	1771924136	1774516136
10	7	382	4	IKrmyEMzRTMp58IFHzMRh3CX	socks5://u29913:z9RVB70FLo4@130.193.41.234:29913	expired	1771924136	1774516136
11	7	382	5	1g8lbpYwId3zg9AA4Jxy70wJ	socks5://u29914:vLvf0WNgPeA@130.193.41.234:29914	expired	1771924136	1774516136
217	93	2188	1	UhUHNSkuYYZY1VAR6pU760N-	socks5://u29907:rGM_vDzLihA@130.193.41.234:29907	active	1774528886	1782304886
218	93	2188	2	3VPM80yv1_uji93871K2guva	socks5://u29908:E6Xp1uOg-GY@130.193.41.234:29908	active	1774528886	1782304886
219	93	2188	3	GUUmnw1-AbG7X-JNwlmIYM4p	socks5://u29909:Sh4_gGuE3L0@130.193.41.234:29909	active	1774528886	1782304886
220	93	2188	4	UaRaJ7-8pXEPI355rV6Bs8y3	socks5://u29910:rgO97TYpc20@130.193.41.234:29910	active	1774528886	1782304886
221	93	2188	5	UlCgbfzy28_OpK5p5sCIh0U_	socks5://u29911:e57n3z7jI6A@130.193.41.234:29911	active	1774528886	1782304886
222	94	2203	1	hrjHIDAXFNrvKatGYI6pUzw1	socks5://u29912:X0Ihtinjroo@130.193.41.234:29912	active	1774533146	1777125146
26	18	1135	5	AS1dx7aPuTreAEKq27i4tQu1	socks5://u29929:j1G2zL4HZQs@130.193.41.234:29929	expired	1771944425	1774536425
224	96	1143	1	i84b2LYoNXREMgPUJEEIVCz6	socks5://u29914:vLvf0WNgPeA@130.193.41.234:29914	active	1774537203	1777129203
225	97	296	1	HuZhYTv_DaSkgRes9wwhZ0k3	socks5://u29915:ukg4I07dtK8@130.193.41.234:29915	active	1774539290	1777131290
226	98	11	1	hT63quIz1CMUPR0EQzwlVX2c	socks5://u29917:UjBQXZ2M3Lw@130.193.41.234:29917	active	1774543523	1775407523
227	99	1149	1	K6JxZJMem3ESbalOujhCjKLw	socks5://u29918:mDuBQK9r_40@130.193.41.234:29918	active	1774545022	1777137022
228	100	1154	1	5haD8qeAZiwOjKb0G-ndHd0j	socks5://u29919:Taat2PvdizA@130.193.41.234:29919	active	1774547186	1777139186
215	91	11	1	PIo7lmJOtoQqddhojeqwKXKt	socks5://u30114:3Fyc_lyj_T0@130.193.41.234:30114	expired	1774468725	1774555125
223	95	11	1	R3z-6N9fqclick6skGM0TtFR	socks5://u29913:z9RVB70FLo4@130.193.41.234:29913	expired	1774533522	1774619922
\.


--
-- Data for Name: proxy_pool; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.proxy_pool (id, port, username, password, status, assigned_link_id, created_at, updated_at) FROM stdin;
24	29927	u29927	Ho0i-yzp-HE	free	\N	1771856469	1774649348
25	29928	u29928	OVuNC2WgH5w	free	\N	1771856469	1774649348
87	29990	u29990	ukufgR1KafI	assigned	88	1771856469	1774649348
141	30044	u30044	z50EemoyeGs	assigned	142	1771856469	1774649348
142	30045	u30045	ckB1rKr0ZSk	assigned	143	1771856469	1774649348
156	30059	u30059	y6hLTBwdxS4	assigned	157	1771856469	1774649348
157	30060	u30060	_hS_ctxWAl4	assigned	158	1771856469	1774649348
186	30089	u30089	tLeDZWUidcc	assigned	187	1771856469	1774649348
187	30090	u30090	qaHqlP0PwcA	assigned	188	1771856469	1774649348
209	30112	u30112	wzX7b0ieWiQ	assigned	210	1771856469	1774649348
210	30113	u30113	NSecJSi74uk	assigned	211	1771856469	1774649348
235	30138	u30138	I9dwhV1NIzA	free	\N	1771856469	1774649348
237	30140	u30140	JUXQuMT7bkg	free	\N	1771856469	1774649348
239	30142	u30142	3jxVeK7o1ZE	free	\N	1771856469	1774649348
240	30143	u30143	S2tSzCzH0ek	free	\N	1771856469	1774649348
241	30144	u30144	8SH5exM-Izk	free	\N	1771856469	1774649348
242	30145	u30145	uocsXTg-tjY	free	\N	1771856469	1774649348
293	30196	u30196	H7mTP2tUWD4	free	\N	1771856469	1774649348
418	30321	u30321	d0zsTK0wNCM	free	\N	1771856469	1774649348
419	30322	u30322	QmsGnwGptP0	free	\N	1771856469	1774649348
420	30323	u30323	Oiu_yZjgAgU	free	\N	1771856469	1774649348
421	30324	u30324	bh7xV40HH3A	free	\N	1771856469	1774649348
422	30325	u30325	fXdkQnrtEyY	free	\N	1771856469	1774649348
423	30326	u30326	qeLfJtE-g-4	free	\N	1771856469	1774649348
425	30328	u30328	vF6KB49tvTI	free	\N	1771856469	1774649348
471	30374	u30374	Mwk0Es84rSU	free	\N	1771856469	1774649348
473	30376	u30376	EIhJJoz29_4	free	\N	1771856469	1774649348
487	30390	u30390	nBuk1vUv9Tc	free	\N	1771856469	1774649348
488	30391	u30391	1io5VYsXebs	free	\N	1771856469	1774649348
250	30153	u30153	CPvA6ibL7RE	free	\N	1771856469	1774649348
1	29904	u29904	ozpQjefbpfE	assigned	212	1771856469	1774649348
8	29911	u29911	e57n3z7jI6A	assigned	221	1771856469	1774649348
12	29915	u29915	ukg4I07dtK8	assigned	225	1771856469	1774649348
52	29955	u29955	AzLo7AuSiHM	assigned	53	1771856469	1774649348
73	29976	u29976	oGIljvMnneU	assigned	74	1771856469	1774649348
98	30001	u30001	cOwNdQ-f3KM	assigned	99	1771856469	1774649348
112	30015	u30015	J-49r6H5HpY	assigned	113	1771856469	1774649348
145	30048	u30048	3SNCc6zq-fQ	assigned	146	1771856469	1774649348
154	30057	u30057	vMY3Q84-N40	assigned	155	1771856469	1774649348
212	30115	u30115	oGNsPaPapQ4	assigned	216	1771856469	1774649348
271	30174	u30174	4WFdPniJEh8	free	\N	1771856469	1774649348
274	30177	u30177	OBD1Sbu2t9Y	free	\N	1771856469	1774649348
316	30219	u30219	FKOsfye1MJg	free	\N	1771856469	1774649348
323	30226	u30226	3ZTpBDljV_k	free	\N	1771856469	1774649348
367	30270	u30270	iNTEhJiSU-c	free	\N	1771856469	1774649348
385	30288	u30288	00x6nuR07ew	free	\N	1771856469	1774649348
400	30303	u30303	Z2XyeqikMus	free	\N	1771856469	1774649348
411	30314	u30314	GrgcsYTHnTs	free	\N	1771856469	1774649348
459	30362	u30362	eDSMqJjCiEg	free	\N	1771856469	1774649348
478	30381	u30381	Uk9OQQqJpdM	free	\N	1771856469	1774649348
20	29923	u29923	EX_DGMO1_aE	assigned	232	1771856469	1774649348
21	29924	u29924	Jsdm9yVhOow	assigned	233	1771856469	1774649348
22	29925	u29925	_2oEmv8NxUM	assigned	234	1771856469	1774649348
23	29926	u29926	Pvbd3mbaTdU	free	\N	1771856469	1774649348
39	29942	u29942	4SRbe7WToEg	assigned	40	1771856469	1774649348
40	29943	u29943	8KFLysn7Y34	assigned	41	1771856469	1774649348
43	29946	u29946	zxfn7GjrYuI	assigned	44	1771856469	1774649348
54	29957	u29957	0SvCZO3IDoI	assigned	55	1771856469	1774649348
60	29963	u29963	zc0hbeg16HQ	assigned	61	1771856469	1774649348
61	29964	u29964	PnGUC0IHn2w	assigned	62	1771856469	1774649348
65	29968	u29968	Td-uhbBZF6s	assigned	66	1771856469	1774649348
66	29969	u29969	S_7bW84YCQk	assigned	67	1771856469	1774649348
442	30345	u30345	mTIcD5u4xIE	free	\N	1771856469	1774649348
443	30346	u30346	781TMKIlQz4	free	\N	1771856469	1774649348
444	30347	u30347	H9f4ZmaKtAs	free	\N	1771856469	1774649348
363	30266	u30266	R8e4nAGqGM4	free	\N	1771856469	1774649348
424	30327	u30327	Q7eqzH0T9eo	free	\N	1771856469	1774649348
445	30348	u30348	8UB6KpNQGdo	free	\N	1771856469	1774649348
371	30274	u30274	JUEsKcn2Skg	free	\N	1771856469	1774649348
446	30349	u30349	njWfxetqNwA	free	\N	1771856469	1774649348
67	29970	u29970	x1pREBnstPE	assigned	68	1771856469	1774649348
70	29973	u29973	QpL_m5Mzd5I	assigned	71	1771856469	1774649348
92	29995	u29995	ls8dilOsVL8	assigned	93	1771856469	1774649348
93	29996	u29996	x85u8FmkxnQ	assigned	94	1771856469	1774649348
94	29997	u29997	FGopS1BOP2Q	assigned	95	1771856469	1774649348
95	29998	u29998	65LhEDzUQCU	assigned	96	1771856469	1774649348
96	29999	u29999	yHxvFfEgavE	assigned	97	1771856469	1774649348
97	30000	u30000	P82lrfZmZXU	assigned	98	1771856469	1774649348
104	30007	u30007	E_dSDW4LK0E	assigned	105	1771856469	1774649348
108	30011	u30011	ZWEdtdfIBuQ	assigned	109	1771856469	1774649348
111	30014	u30014	ol0DY8MxLHg	assigned	112	1771856469	1774649348
113	30016	u30016	IdiO5yjiIsU	assigned	114	1771856469	1774649348
129	30032	u30032	VZeSh4OXE20	assigned	130	1771856469	1774649348
138	30041	u30041	oqUx_L1BRBA	assigned	139	1771856469	1774649348
139	30042	u30042	GENftTMm4fo	assigned	140	1771856469	1774649348
143	30046	u30046	mp1z50R_8NU	assigned	144	1771856469	1774649348
150	30053	u30053	Llx2_tOy4bc	assigned	151	1771856469	1774649348
159	30062	u30062	tt16tU585UY	assigned	160	1771856469	1774649348
174	30077	u30077	-KUZ-pYu_XY	assigned	175	1771856469	1774649348
177	30080	u30080	RKtDYkvSgH8	assigned	178	1771856469	1774649348
179	30082	u30082	tAwOERI371I	assigned	180	1771856469	1774649348
215	30118	u30118	VRN1KKsSGQM	free	\N	1771856469	1774649348
220	30123	u30123	8-_mFWylw9s	free	\N	1771856469	1774649348
221	30124	u30124	I-YnOM2vB30	free	\N	1771856469	1774649348
230	30133	u30133	AC67akviSi0	free	\N	1771856469	1774649348
256	30159	u30159	n85l6aOQ23E	free	\N	1771856469	1774649348
260	30163	u30163	5Wj1HWg9p4s	free	\N	1771856469	1774649348
261	30164	u30164	LrjiXBUb5oo	free	\N	1771856469	1774649348
268	30171	u30171	XkCW4RMqaPs	free	\N	1771856469	1774649348
372	30275	u30275	8765gI2OKZ0	free	\N	1771856469	1774649348
406	30309	u30309	iquecFQcw5A	free	\N	1771856469	1774649348
407	30310	u30310	hVHPBveP4U4	free	\N	1771856469	1774649348
432	30335	u30335	d8IkNKDqH4w	free	\N	1771856469	1774649348
439	30342	u30342	X4qNdpIp1sA	free	\N	1771856469	1774649348
440	30343	u30343	HCGr7jKJBxY	free	\N	1771856469	1774649348
441	30344	u30344	_2vbaX0TEbE	free	\N	1771856469	1774649348
2	29905	u29905	MWwLbBJvJJg	assigned	213	1771856469	1774649348
3	29906	u29906	gAyH-Kwiw3c	assigned	214	1771856469	1774649348
16	29919	u29919	Taat2PvdizA	assigned	228	1771856469	1774649348
18	29921	u29921	JrEsVIsgbrg	assigned	230	1771856469	1774649348
19	29922	u29922	0lHqgaJvIws	assigned	231	1771856469	1774649348
26	29929	u29929	j1G2zL4HZQs	free	\N	1771856469	1774649348
27	29930	u29930	MsRN5LSBA-s	free	\N	1771856469	1774649348
29	29932	u29932	qKOgmxCbqhI	free	\N	1771856469	1774649348
36	29939	u29939	fkr1VXPOBHY	free	\N	1771856469	1774649348
37	29940	u29940	mW99XBcjL-E	free	\N	1771856469	1774649348
38	29941	u29941	t0s3X5HbdC8	assigned	39	1771856469	1774649348
44	29947	u29947	ITDwe5Yq57Y	assigned	45	1771856469	1774649348
45	29948	u29948	2u3XKAcWQR4	assigned	46	1771856469	1774649348
46	29949	u29949	TWK4T1CMawA	assigned	47	1771856469	1774649348
47	29950	u29950	EzcjaZW1Wzc	assigned	48	1771856469	1774649348
48	29951	u29951	tPEz3X8b_0A	assigned	49	1771856469	1774649348
50	29953	u29953	G14cNJqB6q4	assigned	51	1771856469	1774649348
53	29956	u29956	ATzuRXB7pp4	assigned	54	1771856469	1774649348
362	30265	u30265	5TtRHjXbDak	free	\N	1771856469	1774649348
17	29920	u29920	RBwC6NMSLWE	assigned	229	1771856469	1774649348
68	29971	u29971	Isp0ZHCVsx4	assigned	69	1771856469	1774649348
69	29972	u29972	UI3pYq-E6jc	assigned	70	1771856469	1774649348
115	30018	u30018	TW8Mozd4gq8	assigned	116	1771856469	1774649348
227	30130	u30130	P0WF86to3NE	free	\N	1771856469	1774649348
228	30131	u30131	afEWxrr8_Gc	free	\N	1771856469	1774649348
131	30034	u30034	SKIWZeD_jEQ	assigned	132	1771856469	1774649348
106	30009	u30009	j8RamzCjJ0g	assigned	107	1771856469	1774649348
270	30173	u30173	Miko80QseTI	free	\N	1771856469	1774649348
132	30035	u30035	JFOMDBBPrTg	assigned	133	1771856469	1774649348
136	30039	u30039	1RqXtqZGQn0	assigned	137	1771856469	1774649348
291	30194	u30194	b8EO-H6bg5o	free	\N	1771856469	1774649348
245	30148	u30148	xPvD2oTEm6Q	free	\N	1771856469	1774649348
247	30150	u30150	cV07uXzFSYA	free	\N	1771856469	1774649348
254	30157	u30157	xOok5e_oHUo	free	\N	1771856469	1774649348
182	30085	u30085	WObHROf5iu4	assigned	183	1771856469	1774649348
192	30095	u30095	Ukpm2EyVLgU	assigned	193	1771856469	1774649348
262	30165	u30165	VI_I0nGIiZs	free	\N	1771856469	1774649348
266	30169	u30169	nEsX5vJNIBI	free	\N	1771856469	1774649348
269	30172	u30172	Z-l3Og05J7c	free	\N	1771856469	1774649348
305	30208	u30208	2mNXRVkTHec	free	\N	1771856469	1774649348
365	30268	u30268	PRSeP4zhxik	free	\N	1771856469	1774649348
366	30269	u30269	URqVfmBK7wM	free	\N	1771856469	1774649348
436	30339	u30339	nRGBLSrWQ_Q	free	\N	1771856469	1774649348
447	30350	u30350	KVPd5fBVSzc	free	\N	1771856469	1774649348
9	29912	u29912	X0Ihtinjroo	assigned	222	1771856469	1774649348
10	29913	u29913	z9RVB70FLo4	free	\N	1771856469	1774649348
11	29914	u29914	vLvf0WNgPeA	assigned	224	1771856469	1774649348
13	29916	u29916	GtZ3akIJhAI	assigned	38	1771856469	1774649348
31	29934	u29934	jUEX4ExZ0NI	free	\N	1771856469	1774649348
33	29936	u29936	BKuOmxhtA8w	assigned	33	1771856469	1774649348
41	29944	u29944	Z7YUQrtpSOY	assigned	42	1771856469	1774649348
42	29945	u29945	w9HX0UKvkWk	assigned	43	1771856469	1774649348
71	29974	u29974	Wtr707DzVn8	assigned	72	1771856469	1774649348
74	29977	u29977	DYaF6NQPtJA	assigned	75	1771856469	1774649348
75	29978	u29978	vkZ2Ckx7O8g	assigned	76	1771856469	1774649348
76	29979	u29979	wY6f7o8rx4g	assigned	77	1771856469	1774649348
77	29980	u29980	MUHGZD2WxRc	assigned	78	1771856469	1774649348
83	29986	u29986	SO4oYQiIw8g	assigned	84	1771856469	1774649348
85	29988	u29988	-yjjz3yyJCs	assigned	86	1771856469	1774649348
86	29989	u29989	3QpSqj_VOgA	assigned	87	1771856469	1774649348
88	29991	u29991	DpnzRGWSpkY	assigned	89	1771856469	1774649348
89	29992	u29992	Ma53JIT3SmY	assigned	90	1771856469	1774649348
90	29993	u29993	1QVMCirzSH0	assigned	91	1771856469	1774649348
99	30002	u30002	T2Psko3GeFk	assigned	100	1771856469	1774649348
100	30003	u30003	ZjYBo9myaJs	assigned	101	1771856469	1774649348
101	30004	u30004	c1CaqRQKjdY	assigned	102	1771856469	1774649348
102	30005	u30005	kcp8dnvSyC8	assigned	103	1771856469	1774649348
103	30006	u30006	sMAIye6yq1w	assigned	104	1771856469	1774649348
105	30008	u30008	3HzQkXkQjPs	assigned	106	1771856469	1774649348
109	30012	u30012	rZAA3LxRFYM	assigned	110	1771856469	1774649348
110	30013	u30013	sMx_JuPvPSc	assigned	111	1771856469	1774649348
120	30023	u30023	1Bf3Sg9yYaU	assigned	121	1771856469	1774649348
121	30024	u30024	AumlGUMw6TA	assigned	122	1771856469	1774649348
122	30025	u30025	s5KVi_umS_c	assigned	123	1771856469	1774649348
124	30027	u30027	x3xmP_ON9qM	assigned	125	1771856469	1774649348
126	30029	u30029	fckA_d3M3CI	assigned	127	1771856469	1774649348
127	30030	u30030	5fdNQB70mL8	assigned	128	1771856469	1774649348
128	30031	u30031	qTEuBPsv3Bc	assigned	129	1771856469	1774649348
130	30033	u30033	UiTeK7EfqrQ	assigned	131	1771856469	1774649348
137	30040	u30040	taC0Mus3wM0	assigned	138	1771856469	1774649348
140	30043	u30043	j2xvSzVLs-g	assigned	141	1771856469	1774649348
144	30047	u30047	7JT0PdZIl-g	assigned	145	1771856469	1774649348
147	30050	u30050	nEllXEgh1aM	assigned	148	1771856469	1774649348
148	30051	u30051	GCUopnxmVFQ	assigned	149	1771856469	1774649348
151	30054	u30054	eJqLS9Z2hqs	assigned	152	1771856469	1774649348
153	30056	u30056	TxuWvASRHv8	assigned	154	1771856469	1774649348
180	30083	u30083	SxI9Nml9hvE	assigned	181	1771856469	1774649348
181	30084	u30084	ZVSX2DovZU8	assigned	182	1771856469	1774649348
183	30086	u30086	FcLZdROq06w	assigned	184	1771856469	1774649348
184	30087	u30087	v7VZ1dBZwMs	assigned	185	1771856469	1774649348
185	30088	u30088	v3dWbSU0_cg	assigned	186	1771856469	1774649348
189	30092	u30092	aQrNcTftMhY	assigned	190	1771856469	1774649348
190	30093	u30093	Wt9J8ukzK3Y	assigned	191	1771856469	1774649348
193	30096	u30096	n4qGZgOMCEw	assigned	194	1771856469	1774649348
248	30151	u30151	v3XTWGcIZdY	free	\N	1771856469	1774649348
272	30175	u30175	yfz_DTBxjME	free	\N	1771856469	1774649348
78	29981	u29981	e0i9eS1HXss	assigned	79	1771856469	1774649348
79	29982	u29982	wtgH-09dpL8	assigned	80	1771856469	1774649348
133	30036	u30036	cBNokpFWZiI	assigned	134	1771856469	1774649348
135	30038	u30038	h3eFYaW1GOI	assigned	136	1771856469	1774649348
51	29954	u29954	xTf9NaIR234	assigned	52	1771856469	1774649348
396	30299	u30299	7Wxkl9oattA	free	\N	1771856469	1774649348
155	30058	u30058	nCmMX8foP2k	assigned	156	1771856469	1774649348
455	30358	u30358	1UQkaPQnUKw	free	\N	1771856469	1774649348
295	30198	u30198	ulFbUSUeJGA	free	\N	1771856469	1774649348
281	30184	u30184	ozO4E-JuVWY	free	\N	1771856469	1774649348
300	30203	u30203	YVpPTnxGIxw	free	\N	1771856469	1774649348
460	30363	u30363	P6eEEl0dwUw	free	\N	1771856469	1774649348
15	29918	u29918	mDuBQK9r_40	assigned	227	1771856469	1774649348
161	30064	u30064	D4b-rVZVqBc	assigned	162	1771856469	1774649348
306	30209	u30209	wMWwmVZoVZ0	free	\N	1771856469	1774649348
320	30223	u30223	kNYcJKjM58Y	free	\N	1771856469	1774649348
163	30066	u30066	o2hDVfY2Smw	assigned	164	1771856469	1774649348
383	30286	u30286	KMTbbLXJZpk	free	\N	1771856469	1774649348
32	29935	u29935	est2Z4Iiv0g	free	\N	1771856469	1774649348
35	29938	u29938	G0qIbmR4LZg	assigned	35	1771856469	1774649348
81	29984	u29984	4eoeAHD0fRI	assigned	82	1771856469	1774649348
123	30026	u30026	nqOiIVX5-Xk	assigned	124	1771856469	1774649348
165	30068	u30068	LYai0vsitBc	assigned	166	1771856469	1774649348
196	30099	u30099	RsKRxFNMwAQ	assigned	197	1771856469	1774649348
198	30101	u30101	lhoalXvpvYY	assigned	199	1771856469	1774649348
200	30103	u30103	9512gRHYp_o	assigned	201	1771856469	1774649348
203	30106	u30106	o8AKre7chkw	assigned	204	1771856469	1774649348
205	30108	u30108	faCFGB_cu2Y	assigned	206	1771856469	1774649348
207	30110	u30110	ry_0wBl1Bq8	assigned	208	1771856469	1774649348
211	30114	u30114	3Fyc_lyj_T0	free	\N	1771856469	1774649348
214	30117	u30117	j40--qM5hQg	free	\N	1771856469	1774649348
219	30122	u30122	MsFTv-VZnws	free	\N	1771856469	1774649348
225	30128	u30128	bhrd_zTG6y4	free	\N	1771856469	1774649348
229	30132	u30132	AjX2QKMd70I	free	\N	1771856469	1774649348
244	30147	u30147	PiyUKyCgEdY	free	\N	1771856469	1774649348
249	30152	u30152	UeMl9hN47LQ	free	\N	1771856469	1774649348
275	30178	u30178	TCFo_raOL1E	free	\N	1771856469	1774649348
284	30187	u30187	NmjqBKi5qDc	free	\N	1771856469	1774649348
287	30190	u30190	6tLUt2jPPy0	free	\N	1771856469	1774649348
289	30192	u30192	y6pi_XhUrPw	free	\N	1771856469	1774649348
84	29987	u29987	A5n9IYuh-e0	assigned	85	1771856469	1774649348
118	30021	u30021	sXKpxdILPOU	assigned	119	1771856469	1774649348
253	30156	u30156	xg0JUivzDkU	free	\N	1771856469	1774649348
265	30168	u30168	8H3kyQNqvF4	free	\N	1771856469	1774649348
223	30126	u30126	wWGyO3TAwG4	free	\N	1771856469	1774649348
226	30129	u30129	Nbv0rYmN7oE	free	\N	1771856469	1774649348
231	30134	u30134	TcGWNoVaXko	free	\N	1771856469	1774649348
162	30065	u30065	pSdHL3xwN1U	assigned	163	1771856469	1774649348
288	30191	u30191	2wfeqGLCD_M	free	\N	1771856469	1774649348
290	30193	u30193	KmpKh2ALIVg	free	\N	1771856469	1774649348
297	30200	u30200	c-kUfkY4OVs	free	\N	1771856469	1774649348
302	30205	u30205	q2GYcmbw0FE	free	\N	1771856469	1774649348
317	30220	u30220	VKqJKM1nQr0	free	\N	1771856469	1774649348
346	30249	u30249	56bZo1TILXo	free	\N	1771856469	1774649348
30	29933	u29933	aRdYEZbQrwQ	free	\N	1771856469	1774649348
34	29937	u29937	YtwIKcCZNpk	free	\N	1771856469	1774649348
80	29983	u29983	RDZLELFRA9k	assigned	81	1771856469	1774649348
82	29985	u29985	oQMU5xWJADE	assigned	83	1771856469	1774649348
116	30019	u30019	RFFkNPZ9ya4	assigned	117	1771856469	1774649348
204	30107	u30107	PIh2CCpw9ks	assigned	205	1771856469	1774649348
246	30149	u30149	aSR3nfQokIg	free	\N	1771856469	1774649348
252	30155	u30155	gP2oIMGE7k0	free	\N	1771856469	1774649348
255	30158	u30158	mJUdxgPLeYE	free	\N	1771856469	1774649348
273	30176	u30176	Uzpk-6XSG5Q	free	\N	1771856469	1774649348
280	30183	u30183	Hwm20ysPgno	free	\N	1771856469	1774649348
282	30185	u30185	qmPHzMUM4sc	free	\N	1771856469	1774649348
286	30189	u30189	aegUcQmaxJA	free	\N	1771856469	1774649348
388	30291	u30291	UM1Cla1iuQk	free	\N	1771856469	1774649348
426	30329	u30329	wCli4sTdV10	free	\N	1771856469	1774649348
457	30360	u30360	W12VkSp9Wfo	free	\N	1771856469	1774649348
463	30366	u30366	aqZ_dEV-FZM	free	\N	1771856469	1774649348
14	29917	u29917	UjBQXZ2M3Lw	assigned	226	1771856469	1774649348
119	30022	u30022	uTYiCaGXib0	assigned	120	1771856469	1774649348
134	30037	u30037	k42iBoH_2Ww	assigned	135	1771856469	1774649348
160	30063	u30063	GXwY4Prd8Js	assigned	161	1771856469	1774649348
164	30067	u30067	xEpfOM--xgY	assigned	165	1771856469	1774649348
194	30097	u30097	cLqUYQVtxdg	assigned	195	1771856469	1774649348
197	30100	u30100	XQpN5rUG7Jo	assigned	198	1771856469	1774649348
199	30102	u30102	NTYM0I_A7Z4	assigned	200	1771856469	1774649348
202	30105	u30105	eYSBXAWYKz0	assigned	203	1771856469	1774649348
208	30111	u30111	VpEx2wVDJrE	assigned	209	1771856469	1774649348
213	30116	u30116	_t9GKOVdzyk	free	\N	1771856469	1774649348
216	30119	u30119	OWZiEY2yig8	free	\N	1771856469	1774649348
206	30109	u30109	nodvovA8Wic	assigned	207	1771856469	1774649348
456	30359	u30359	_Gu0XvumDiI	free	\N	1771856469	1774649348
452	30355	u30355	TTmhC0eMMlQ	free	\N	1771856469	1774649348
462	30365	u30365	7Czi8zddkBI	free	\N	1771856469	1774649348
470	30373	u30373	73BQjPdTUIA	free	\N	1771856469	1774649348
474	30377	u30377	GPYDKd4KH0Y	free	\N	1771856469	1774649348
409	30312	u30312	kS-Tko_FVaY	free	\N	1771856469	1774649348
410	30313	u30313	xbQLlFEyWls	free	\N	1771856469	1774649348
476	30379	u30379	bAoaYBD5tLs	free	\N	1771856469	1774649348
413	30316	u30316	MaBYtkh9O2A	free	\N	1771856469	1774649348
414	30317	u30317	biEzhcUHL54	free	\N	1771856469	1774649348
477	30380	u30380	T48oJyzynaM	free	\N	1771856469	1774649348
475	30378	u30378	Ho2dBhYc3wc	free	\N	1771856469	1774649348
107	30010	u30010	6Se4214ULic	assigned	108	1771856469	1774649348
114	30017	u30017	b0UWzY84sBg	assigned	115	1771856469	1774649348
117	30020	u30020	Jo-uUGhvAOM	assigned	118	1771856469	1774649348
152	30055	u30055	s1VP82ZshvM	assigned	153	1771856469	1774649348
218	30121	u30121	csRZ_jOEEBk	free	\N	1771856469	1774649348
232	30135	u30135	9yI2XOYp9sc	free	\N	1771856469	1774649348
233	30136	u30136	qKU3I6K3XZc	free	\N	1771856469	1774649348
234	30137	u30137	EB9I-nQxvXc	free	\N	1771856469	1774649348
238	30141	u30141	nFal3vQbbDA	free	\N	1771856469	1774649348
294	30197	u30197	5u5cuS4lTIs	free	\N	1771856469	1774649348
296	30199	u30199	-tSnMO1EDA4	free	\N	1771856469	1774649348
299	30202	u30202	50rKOsStpCs	free	\N	1771856469	1774649348
301	30204	u30204	N9l8Yc3qBOI	free	\N	1771856469	1774649348
303	30206	u30206	JU4HPr8y9Jc	free	\N	1771856469	1774649348
304	30207	u30207	DUb76qkBNR8	free	\N	1771856469	1774649348
318	30221	u30221	fDnY3EzPBL4	free	\N	1771856469	1774649348
324	30227	u30227	dEC7gAvXFio	free	\N	1771856469	1774649348
325	30228	u30228	f9hQJvtHIf4	free	\N	1771856469	1774649348
328	30231	u30231	y1WBCurBTu8	free	\N	1771856469	1774649348
329	30232	u30232	Dn-wgLtWHmo	free	\N	1771856469	1774649348
330	30233	u30233	v1VGq-st1gQ	free	\N	1771856469	1774649348
331	30234	u30234	A38XQyBXyhY	free	\N	1771856469	1774649348
332	30235	u30235	Y_QHXaiFM_8	free	\N	1771856469	1774649348
333	30236	u30236	nCUNRNhK6IQ	free	\N	1771856469	1774649348
334	30237	u30237	__UB7UzvuN8	free	\N	1771856469	1774649348
335	30238	u30238	qn5Jwkx-EL4	free	\N	1771856469	1774649348
339	30242	u30242	kFpGpj9We-g	free	\N	1771856469	1774649348
341	30244	u30244	tYr-RxT2EFU	free	\N	1771856469	1774649348
347	30250	u30250	wayGeWxmjFQ	free	\N	1771856469	1774649348
356	30259	u30259	qHPypk5Ymu4	free	\N	1771856469	1774649348
357	30260	u30260	4BLqVFGu5n0	free	\N	1771856469	1774649348
358	30261	u30261	vHl4uZUqxk4	free	\N	1771856469	1774649348
359	30262	u30262	d2i3mtEtn1M	free	\N	1771856469	1774649348
360	30263	u30263	Makf2I6U68o	free	\N	1771856469	1774649348
364	30267	u30267	miiW0Ijym-4	free	\N	1771856469	1774649348
368	30271	u30271	9vt80Aruc08	free	\N	1771856469	1774649348
369	30272	u30272	neCZcEvKnhw	free	\N	1771856469	1774649348
370	30273	u30273	nBAjkMr1ldQ	free	\N	1771856469	1774649348
373	30276	u30276	0725zDnFxcM	free	\N	1771856469	1774649348
374	30277	u30277	sDzuI7ckmR8	free	\N	1771856469	1774649348
375	30278	u30278	137KwFBIWq8	free	\N	1771856469	1774649348
376	30279	u30279	IxaS33XqwJw	free	\N	1771856469	1774649348
379	30282	u30282	j0RJwMGNnLw	free	\N	1771856469	1774649348
380	30283	u30283	G643LQpouis	free	\N	1771856469	1774649348
381	30284	u30284	s-FEg59lNFU	free	\N	1771856469	1774649348
384	30287	u30287	wXTTZLpwJZo	free	\N	1771856469	1774649348
386	30289	u30289	Sxjyr11BsgM	free	\N	1771856469	1774649348
387	30290	u30290	By98cXYbL20	free	\N	1771856469	1774649348
393	30296	u30296	MmqEqFUrBeM	free	\N	1771856469	1774649348
394	30297	u30297	w1oc6g3K1oc	free	\N	1771856469	1774649348
397	30300	u30300	YyKmA9NgBFg	free	\N	1771856469	1774649348
399	30302	u30302	1khCtKpB-uU	free	\N	1771856469	1774649348
408	30311	u30311	LjawwIzwM0M	free	\N	1771856469	1774649348
415	30318	u30318	9UIRcgKw1rM	free	\N	1771856469	1774649348
417	30320	u30320	KHx5iihXYRQ	free	\N	1771856469	1774649348
429	30332	u30332	Q70AGnlS9jw	free	\N	1771856469	1774649348
430	30333	u30333	Cq2mZI6sHCI	free	\N	1771856469	1774649348
435	30338	u30338	B6rbpAeWqfU	free	\N	1771856469	1774649348
438	30341	u30341	7vgFGDvIWrk	free	\N	1771856469	1774649348
448	30351	u30351	iCCtM4o56BQ	free	\N	1771856469	1774649348
449	30352	u30352	XY1RrjoyCak	free	\N	1771856469	1774649348
450	30353	u30353	wKmmTrbB--s	free	\N	1771856469	1774649348
451	30354	u30354	206aWRHp9TQ	free	\N	1771856469	1774649348
453	30356	u30356	aYVahG1lpfA	free	\N	1771856469	1774649348
454	30357	u30357	to6yZE0X30U	free	\N	1771856469	1774649348
461	30364	u30364	15f188gpMIg	free	\N	1771856469	1774649348
466	30369	u30369	OXeoYZxZHtk	free	\N	1771856469	1774649348
467	30370	u30370	T8dnVW-4UW4	free	\N	1771856469	1774649348
468	30371	u30371	DAyTWrql02I	free	\N	1771856469	1774649348
469	30372	u30372	7SFa1Rj1lRE	free	\N	1771856469	1774649348
236	30139	u30139	0ZH1zhXCc6o	free	\N	1771856469	1774649348
283	30186	u30186	eKanPYfWMZM	free	\N	1771856469	1774649348
63	29966	u29966	0TNkaoJZSGY	assigned	64	1771856469	1774649348
64	29967	u29967	PgFOaeB0Nsc	assigned	65	1771856469	1774649348
72	29975	u29975	zFqal7ni3PE	assigned	73	1771856469	1774649348
292	30195	u30195	cyc39TbO3vE	free	\N	1771856469	1774649348
4	29907	u29907	rGM_vDzLihA	assigned	217	1771856469	1774649348
5	29908	u29908	E6Xp1uOg-GY	assigned	218	1771856469	1774649348
298	30201	u30201	hfvtSl7OjVY	free	\N	1771856469	1774649348
307	30210	u30210	yClxv8wTWek	free	\N	1771856469	1774649348
308	30211	u30211	ACIAQmN_B7E	free	\N	1771856469	1774649348
309	30212	u30212	afVuS14Wj0s	free	\N	1771856469	1774649348
321	30224	u30224	Rx0EvG3jqFo	free	\N	1771856469	1774649348
322	30225	u30225	89qp2S9qMJg	free	\N	1771856469	1774649348
327	30230	u30230	-SI9-qLD-eQ	free	\N	1771856469	1774649348
337	30240	u30240	H7TcWZUa0Pw	free	\N	1771856469	1774649348
338	30241	u30241	YQmVv216QL8	free	\N	1771856469	1774649348
340	30243	u30243	OuNjvwMOSw4	free	\N	1771856469	1774649348
344	30247	u30247	6vo8sBz2R-Q	free	\N	1771856469	1774649348
345	30248	u30248	dLNfNSIhMVM	free	\N	1771856469	1774649348
355	30258	u30258	xurm8y_tfeI	free	\N	1771856469	1774649348
361	30264	u30264	dTe0ci9mj9w	free	\N	1771856469	1774649348
377	30280	u30280	kZm3t9HAV9g	free	\N	1771856469	1774649348
378	30281	u30281	_9m1dRMLD8w	free	\N	1771856469	1774649348
382	30285	u30285	T4uJefqROEI	free	\N	1771856469	1774649348
389	30292	u30292	gVIT4Lc-dSo	free	\N	1771856469	1774649348
390	30293	u30293	fGygCuZJUfY	free	\N	1771856469	1774649348
391	30294	u30294	o5yF9tCu1x0	free	\N	1771856469	1774649348
392	30295	u30295	FsVggy80-Ew	free	\N	1771856469	1774649348
395	30298	u30298	TBtZoqQr0Vg	free	\N	1771856469	1774649348
398	30301	u30301	cEyWzIhz0kA	free	\N	1771856469	1774649348
401	30304	u30304	IHZtNRItVM4	free	\N	1771856469	1774649348
402	30305	u30305	LX4A4Xa1jmU	free	\N	1771856469	1774649348
403	30306	u30306	e8E6VRber-4	free	\N	1771856469	1774649348
404	30307	u30307	5A8uu4uZO-c	free	\N	1771856469	1774649348
405	30308	u30308	D2GWVkJadH8	free	\N	1771856469	1774649348
416	30319	u30319	fjg7MYO7qXM	free	\N	1771856469	1774649348
428	30331	u30331	Eu2TEsRCIKo	free	\N	1771856469	1774649348
431	30334	u30334	mUSKvr02xyA	free	\N	1771856469	1774649348
458	30361	u30361	pYX6BI8qs_4	free	\N	1771856469	1774649348
464	30367	u30367	Ah4u6c-m3jE	free	\N	1771856469	1774649348
465	30368	u30368	dOqOsyrfhVM	free	\N	1771856469	1774649348
472	30375	u30375	uDysRb0dZLQ	free	\N	1771856469	1774649348
479	30382	u30382	5s5kIjeIYGs	free	\N	1771856469	1774649348
480	30383	u30383	SlDwIVeRu4g	free	\N	1771856469	1774649348
483	30386	u30386	_uLNsSGlrjM	free	\N	1771856469	1774649348
484	30387	u30387	D90PLcSyQW4	free	\N	1771856469	1774649348
485	30388	u30388	bjhcTl_z6EA	free	\N	1771856469	1774649348
489	30392	u30392	cLouMBGSBXM	free	\N	1771856469	1774649348
497	30400	u30400	dbb2eCJ_ieY	free	\N	1771856469	1774649348
6	29909	u29909	Sh4_gGuE3L0	assigned	219	1771856469	1774649348
7	29910	u29910	rgO97TYpc20	assigned	220	1771856469	1774649348
28	29931	u29931	P4bh2fr4LFg	free	\N	1771856469	1774649348
49	29952	u29952	9DvTIAfA1kk	assigned	50	1771856469	1774649348
55	29958	u29958	eaB9-XX01rs	assigned	56	1771856469	1774649348
56	29959	u29959	xnrUTBm5neA	assigned	57	1771856469	1774649348
57	29960	u29960	H00aqXPsIbo	assigned	58	1771856469	1774649348
58	29961	u29961	0TZOfGcwLOY	assigned	59	1771856469	1774649348
59	29962	u29962	F2i99DlivlU	assigned	60	1771856469	1774649348
62	29965	u29965	zILWBTBSo1U	assigned	63	1771856469	1774649348
91	29994	u29994	nnZyUnyyb1M	assigned	92	1771856469	1774649348
125	30028	u30028	ZUt_06LSClA	assigned	126	1771856469	1774649348
146	30049	u30049	a4_ZJUnpsbY	assigned	147	1771856469	1774649348
158	30061	u30061	GhROAAy19OQ	assigned	159	1771856469	1774649348
166	30069	u30069	7s1MU0jLAHg	assigned	167	1771856469	1774649348
167	30070	u30070	zTHAnslyx_Q	assigned	168	1771856469	1774649348
168	30071	u30071	j7Xr8ElZtZ4	assigned	169	1771856469	1774649348
169	30072	u30072	xheDMZ_Pv0Q	assigned	170	1771856469	1774649348
188	30091	u30091	xflu8UveW60	assigned	189	1771856469	1774649348
243	30146	u30146	eCqgwVGLCQk	free	\N	1771856469	1774649348
263	30166	u30166	acY6_b0jsAU	free	\N	1771856469	1774649348
264	30167	u30167	Z4XTiXcLgIo	free	\N	1771856469	1774649348
278	30181	u30181	yLigeG82_qA	free	\N	1771856469	1774649348
279	30182	u30182	MXHJCQgiD4s	free	\N	1771856469	1774649348
285	30188	u30188	TfiXey9jHI0	free	\N	1771856469	1774649348
336	30239	u30239	J_cuqc-Uk4w	free	\N	1771856469	1774649348
342	30245	u30245	4z_HqJxDbWk	free	\N	1771856469	1774649348
343	30246	u30246	PveJ4m-FS2s	free	\N	1771856469	1774649348
176	30079	u30079	kVUjk4zGNH4	assigned	177	1771856469	1774649348
412	30315	u30315	4KjrArJKo3A	free	\N	1771856469	1774649348
427	30330	u30330	lGs-KhQuWRg	free	\N	1771856469	1774649348
433	30336	u30336	y2QDTdCcHNo	free	\N	1771856469	1774649348
434	30337	u30337	Ni0d8JbASKA	free	\N	1771856469	1774649348
437	30340	u30340	sencnQJAhYU	free	\N	1771856469	1774649348
276	30179	u30179	BZyu0bigZ-c	free	\N	1771856469	1774649348
277	30180	u30180	mWTwpx0Z-4E	free	\N	1771856469	1774649348
490	30393	u30393	RbMYcryignI	free	\N	1771856469	1774649348
491	30394	u30394	VYqBIByeIJw	free	\N	1771856469	1774649348
492	30395	u30395	6Po8x1CeuOE	free	\N	1771856469	1774649348
493	30396	u30396	vDAavf2Naxc	free	\N	1771856469	1774649348
494	30397	u30397	pa2OzO9XqJg	free	\N	1771856469	1774649348
495	30398	u30398	PK9HtfmspZ0	free	\N	1771856469	1774649348
149	30052	u30052	7Py5Bs4PXEE	assigned	150	1771856469	1774649348
170	30073	u30073	6YiKFX-ltbU	assigned	171	1771856469	1774649348
496	30399	u30399	vWDoDB4NZgE	free	\N	1771856469	1774649348
171	30074	u30074	7fGZUw6WKwM	assigned	172	1771856469	1774649348
172	30075	u30075	mxFLQr0sPwE	assigned	173	1771856469	1774649348
173	30076	u30076	UYtMz9gqkPA	assigned	174	1771856469	1774649348
175	30078	u30078	LF6mRpVvbJw	assigned	176	1771856469	1774649348
178	30081	u30081	qfQtRSgs2D8	assigned	179	1771856469	1774649348
191	30094	u30094	mHIfnrmuDVE	assigned	192	1771856469	1774649348
195	30098	u30098	ucocP1qbWkE	assigned	196	1771856469	1774649348
201	30104	u30104	1LSGOZyAz2c	assigned	202	1771856469	1774649348
217	30120	u30120	txUjLTc8Gnc	free	\N	1771856469	1774649348
222	30125	u30125	jliUjCQYPGU	free	\N	1771856469	1774649348
224	30127	u30127	MNa6UcKE3hA	free	\N	1771856469	1774649348
251	30154	u30154	u0PA0pqnRww	free	\N	1771856469	1774649348
257	30160	u30160	UunwuhoH_9k	free	\N	1771856469	1774649348
258	30161	u30161	7AL4-2wZm34	free	\N	1771856469	1774649348
259	30162	u30162	ylRCWEpoiWw	free	\N	1771856469	1774649348
267	30170	u30170	q-78HxmRhLw	free	\N	1771856469	1774649348
310	30213	u30213	NCF-_LuhN_k	free	\N	1771856469	1774649348
311	30214	u30214	QXtkuuZdQt8	free	\N	1771856469	1774649348
312	30215	u30215	cIYG_ImZ_6A	free	\N	1771856469	1774649348
313	30216	u30216	TTYHM_2A3kM	free	\N	1771856469	1774649348
314	30217	u30217	2kb2a78HiOE	free	\N	1771856469	1774649348
315	30218	u30218	Fph8OpWlcdw	free	\N	1771856469	1774649348
319	30222	u30222	tCncLHRnV2Y	free	\N	1771856469	1774649348
326	30229	u30229	nvWaXNSEmf0	free	\N	1771856469	1774649348
348	30251	u30251	1AGSnP133E4	free	\N	1771856469	1774649348
349	30252	u30252	UWRBgYvevrw	free	\N	1771856469	1774649348
350	30253	u30253	60qJaqnJULc	free	\N	1771856469	1774649348
351	30254	u30254	5AoD8YO3KyA	free	\N	1771856469	1774649348
352	30255	u30255	sx8BCAfSU9Y	free	\N	1771856469	1774649348
353	30256	u30256	kJT71JhXMYc	free	\N	1771856469	1774649348
354	30257	u30257	5rJ9f_lp0wc	free	\N	1771856469	1774649348
481	30384	u30384	oAMSzHz5qIM	free	\N	1771856469	1774649348
482	30385	u30385	lk-TIALQ23Y	free	\N	1771856469	1774649348
486	30389	u30389	BAiOOE-Qh3A	free	\N	1771856469	1774649348
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.subscriptions (id, user_id, plan_code, payment_id, status, created_at, expires_at, notified_expired, notified_expiring_2days) FROM stdin;
78	1997	one	172	active	1774253093	1776845093	0	0
25	1195	one	94	active	1771948492	1779724492	0	0
27	1211	one	96	active	1771949566	1780589566	0	0
9	11	one	25	expired	1771934483	1772020883	1	1
30	1254	one	105	active	1772022156	1777206156	0	0
31	1350	five	108	active	1772122264	1803226264	0	0
32	1337	fifteen	110	active	1772174015	1803278015	0	0
33	1389	one	111	active	1772186027	1803290027	0	0
34	11	one	112	active	1772367963	1858767963	0	0
35	11	one	113	active	1772368186	1858768186	0	0
36	1445	five	115	active	1772559044	1775151044	0	0
37	1453	fifteen	116	active	1772620692	1803724692	0	0
38	1230	one	118	active	1772951945	1804055945	0	0
39	1492	one	119	active	1773085430	1778269430	0	0
40	11	one	123	active	1773580226	1859980226	0	0
41	1544	one	125	active	1773653698	1776245698	0	0
42	1568	one	127	active	1773659010	1776251010	0	0
43	11	one	128	active	1773659496	1860059496	0	0
44	1584	one	129	active	1773682724	1776274724	0	0
45	11	one	130	active	1773817747	1860217747	0	0
46	1624	fifteen	131	active	1773838369	1804942369	0	0
47	1644	one	135	active	1773912486	1776504486	0	0
48	1	fifteen	136	active	1773916855	1784284855	0	0
49	1702	one	138	active	1773925424	1776517424	0	0
50	1713	one	139	active	1773993738	1776585738	0	0
51	1714	five	140	active	1773993751	1776585751	0	0
52	1734	one	142	active	1773994117	1776586117	0	0
53	1742	one	143	active	1773994437	1776586437	0	0
54	1749	one	144	active	1773994653	1776586653	0	0
55	1729	one	141	active	1773995198	1776587198	0	0
56	1752	one	147	active	1773995260	1776587260	0	0
57	1788	one	148	active	1773995967	1776587967	0	0
58	1751	one	146	active	1773996752	1776588752	0	0
59	11	one	149	active	1774002799	1860402799	0	0
60	1798	one	150	active	1774005443	1776597443	0	0
61	1813	one	151	active	1774010280	1776602280	0	0
62	1638	one	154	active	1774015369	1779199369	0	0
63	1713	five	156	active	1774016374	1781792374	0	0
64	1861	one	157	active	1774019689	1776611689	0	0
65	1867	five	158	active	1774020216	1805124216	0	0
66	1874	one	159	active	1774024090	1776616090	0	0
67	1882	one	160	active	1774078929	1805182929	0	0
68	11	one	161	active	1774082746	1860482746	0	0
69	1897	one	162	active	1774086574	1776678574	0	0
70	1903	five	163	active	1774088618	1781864618	0	0
71	1910	one	164	active	1774102667	1776694667	0	0
72	1713	fifteen	165	active	1774109680	1776701680	0	0
73	1897	five	166	active	1774118319	1776710319	0	0
74	1938	five	167	active	1774129998	1781905998	0	0
75	1952	fifteen	168	active	1774158233	1781934233	0	0
76	1203	one	169	active	1774199161	1781975161	0	0
77	1986	one	171	active	1774252226	1776844226	0	0
79	1556	one	170	active	1774257938	1776849938	0	0
2	11	one	3	expired	1771857251	1774449251	1	1
3	11	one	7	expired	1771864096	1774456096	1	1
4	11	one	14	expired	1771911418	1774503418	1	1
5	326	one	16	expired	1771912508	1774504508	1	1
6	11	one	19	expired	1771913545	1774505545	1	1
80	11	one	173	active	1774342340	1774947140	0	0
7	382	five	21	expired	1771924136	1774516136	1	1
81	2043	one	174	active	1774346162	1789898162	0	0
8	393	one	23	expired	1771929625	1774521625	1	1
82	1713	one	175	active	1774350470	1776942470	0	0
83	382	one	176	active	1774350621	1776942621	0	0
84	767	one	177	active	1774352039	1776944039	0	0
85	775	one	178	active	1774352089	1776944089	0	0
10	11	one	29	expired	1771935522	1774527522	1	1
11	11	one	30	expired	1771935875	1774527875	1	1
12	11	one	66	expired	1771936660	1774528660	1	1
13	11	one	69	expired	1771936937	1774528937	1	1
14	326	one	70	expired	1771937059	1774529059	1	1
15	767	one	76	expired	1771938619	1774530619	1	1
17	296	one	86	expired	1771943908	1774535908	1	1
18	1135	five	87	expired	1771944425	1774536425	1	1
19	1143	one	88	expired	1771944684	1774536684	1	1
20	1149	one	89	expired	1771944816	1774536816	1	1
21	1154	one	90	expired	1771944830	1774536830	1	1
22	1161	one	91	expired	1771945368	1774537368	1	1
23	1172	one	92	expired	1771946596	1774538596	1	1
24	1181	one	93	expired	1771947390	1774539390	1	1
26	1203	one	95	expired	1771948673	1774540673	1	1
28	1118	one	97	expired	1771951955	1774543955	1	1
86	2094	one	181	active	1774372416	1782148416	0	0
29	775	one	98	expired	1771957732	1774549732	1	1
87	2098	one	182	active	1774381368	1782157368	0	0
1	1	one	2	expired	1771857147	1774449147	1	1
88	2142	one	186	active	1774450335	1782226335	0	0
89	11	one	187	active	1774450468	1860850468	0	0
90	2159	one	188	active	1774457850	1805561850	0	0
92	2176	one	190	active	1774496378	1782272378	0	0
93	2188	five	191	active	1774528886	1782304886	0	0
16	776	one	77	expired	1771939346	1774531346	1	1
94	2203	one	192	active	1774533146	1777125146	0	0
96	1143	one	194	active	1774537203	1777129203	0	0
97	296	one	195	active	1774539290	1777131290	0	0
98	11	one	196	active	1774543523	1775407523	0	0
99	1149	one	197	active	1774545022	1777137022	0	0
100	1154	one	198	active	1774547186	1777139186	0	0
91	11	one	189	expired	1774468725	1774555125	1	1
101	11	one	200	active	1774597384	1774683784	0	1
102	1395	five	202	active	1774610062	1805714062	0	0
95	11	one	193	expired	1774533522	1774619922	1	1
\.


--
-- Data for Name: user_temp_messages; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.user_temp_messages (id, user_id, tg_user_id, message_id, kind, created_at) FROM stdin;
684	382	903449432	2269	proxy_output	1774350623
685	382	903449432	2270	proxy_output	1774350623
324	1445	665410048	1322	proxy_output	1772559044
325	1445	665410048	1323	proxy_output	1772559044
326	1445	665410048	1324	proxy_output	1772559045
327	1445	665410048	1325	proxy_output	1772559045
328	1445	665410048	1326	proxy_output	1772559045
329	1445	665410048	1327	proxy_output	1772559045
330	1445	665410048	1328	proxy_output	1772559045
331	1453	6048846195	1336	proxy_output	1772620692
332	1453	6048846195	1337	proxy_output	1772620692
333	1453	6048846195	1338	proxy_output	1772620692
334	1453	6048846195	1339	proxy_output	1772620693
335	1453	6048846195	1340	proxy_output	1772620693
336	1453	6048846195	1341	proxy_output	1772620693
337	1453	6048846195	1342	proxy_output	1772620693
338	1453	6048846195	1343	proxy_output	1772620694
686	767	1417827742	2273	proxy_output	1774352040
522	1903	366906750	1895	proxy_output	1774088619
523	1903	366906750	1896	proxy_output	1774088619
524	1903	366906750	1897	proxy_output	1774088619
525	1903	366906750	1898	proxy_output	1774088619
526	1903	366906750	1899	proxy_output	1774088620
527	1903	366906750	1900	proxy_output	1774088620
95	393	374962741	448	proxy_output	1771929626
96	393	374962741	449	proxy_output	1771929626
97	393	374962741	450	proxy_output	1771929626
232	1161	1091492352	982	proxy_output	1771945369
233	1161	1091492352	983	proxy_output	1771945369
234	1161	1091492352	984	proxy_output	1771945369
339	1453	6048846195	1344	proxy_output	1772620694
340	1453	6048846195	1345	proxy_output	1772620694
341	1453	6048846195	1346	proxy_output	1772620694
238	1181	1580415068	1010	proxy_output	1771947390
239	1181	1580415068	1011	proxy_output	1771947390
240	1181	1580415068	1012	proxy_output	1771947390
241	1195	5416731973	1024	proxy_output	1771948492
166	326	7176003171	659	proxy_output	1771937059
167	326	7176003171	660	proxy_output	1771937060
168	326	7176003171	661	proxy_output	1771937060
242	1195	5416731973	1025	proxy_output	1771948492
243	1195	5416731973	1026	proxy_output	1771948493
687	767	1417827742	2274	proxy_output	1774352040
688	775	1144391790	2277	proxy_output	1774352090
689	775	1144391790	2278	proxy_output	1774352090
342	1453	6048846195	1347	proxy_output	1772620694
343	1453	6048846195	1348	proxy_output	1772620695
528	1903	366906750	1901	proxy_output	1774088620
529	1910	5157451253	1907	proxy_output	1774102672
530	1910	5157451253	1908	proxy_output	1774102672
531	1910	5157451253	1909	proxy_output	1774102673
947	11	558396308	2790	proxy_output	1774648795
948	11	558396308	2791	proxy_output	1774648795
692	2098	1246575365	2332	proxy_output	1774381369
693	2098	1246575365	2333	proxy_output	1774381369
694	2098	1246575365	2334	proxy_output	1774381369
695	2142	1904248886	2358	proxy_output	1774450336
696	2142	1904248886	2359	proxy_output	1774450336
697	2142	1904248886	2360	proxy_output	1774450336
276	1254	782071738	1171	proxy_output	1772022156
277	1254	782071738	1172	proxy_output	1772022157
287	1350	262746320	1209	proxy_output	1772122265
288	1350	262746320	1210	proxy_output	1772122265
289	1350	262746320	1211	proxy_output	1772122265
290	1350	262746320	1212	proxy_output	1772122265
291	1350	262746320	1213	proxy_output	1772122266
292	1350	262746320	1214	proxy_output	1772122266
293	1350	262746320	1215	proxy_output	1772122266
311	1389	1290146931	1259	proxy_output	1772186027
312	1389	1290146931	1260	proxy_output	1772186028
313	1389	1290146931	1261	proxy_output	1772186028
314	1172	64504614	1280	proxy_output	1772367888
315	1172	64504614	1281	proxy_output	1772367888
344	1453	6048846195	1349	proxy_output	1772620695
345	1453	6048846195	1350	proxy_output	1772620695
346	1453	6048846195	1351	proxy_output	1772620695
347	1453	6048846195	1352	proxy_output	1772620695
350	1230	266186319	1378	proxy_output	1772951945
351	1230	266186319	1379	proxy_output	1772951946
352	1230	266186319	1380	proxy_output	1772951946
549	1492	795925664	1940	proxy_output	1774111686
550	1492	795925664	1941	proxy_output	1774111686
551	1897	878142505	1944	proxy_output	1774118319
552	1897	878142505	1945	proxy_output	1774118319
553	1897	878142505	1946	proxy_output	1774118319
554	1897	878142505	1947	proxy_output	1774118320
555	1897	878142505	1948	proxy_output	1774118320
556	1897	878142505	1949	proxy_output	1774118320
557	1897	878142505	1950	proxy_output	1774118320
377	1135	854988710	1503	proxy_output	1773779233
378	1135	854988710	1504	proxy_output	1773779233
379	1135	854988710	1505	proxy_output	1773779234
380	1135	854988710	1506	proxy_output	1773779234
381	1135	854988710	1507	proxy_output	1773779234
382	1135	854988710	1508	proxy_output	1773779234
387	1624	8618772238	1528	proxy_output	1773838369
388	1624	8618772238	1529	proxy_output	1773838369
389	1624	8618772238	1530	proxy_output	1773838369
390	1624	8618772238	1531	proxy_output	1773838370
391	1624	8618772238	1532	proxy_output	1773838370
392	1624	8618772238	1533	proxy_output	1773838370
393	1624	8618772238	1534	proxy_output	1773838370
394	1624	8618772238	1535	proxy_output	1773838370
395	1624	8618772238	1536	proxy_output	1773838371
396	1624	8618772238	1537	proxy_output	1773838371
397	1624	8618772238	1538	proxy_output	1773838371
398	1624	8618772238	1539	proxy_output	1773838371
399	1624	8618772238	1540	proxy_output	1773838371
400	1624	8618772238	1541	proxy_output	1773838371
401	1624	8618772238	1542	proxy_output	1773838372
402	1624	8618772238	1543	proxy_output	1773838372
403	1624	8618772238	1544	proxy_output	1773838372
753	2188	931533618	2473	proxy_output	1774528886
754	2188	931533618	2474	proxy_output	1774528886
420	1644	720204235	1613	proxy_output	1773918584
421	1644	720204235	1614	proxy_output	1773918584
422	1702	553941277	1622	proxy_output	1773925425
423	1702	553941277	1623	proxy_output	1773925425
424	1702	553941277	1624	proxy_output	1773925425
755	2188	931533618	2475	proxy_output	1774528886
756	2188	931533618	2476	proxy_output	1774528886
757	2188	931533618	2477	proxy_output	1774528887
428	1714	439864771	1640	proxy_output	1773993752
429	1714	439864771	1641	proxy_output	1773993752
430	1714	439864771	1642	proxy_output	1773993752
431	1714	439864771	1643	proxy_output	1773993752
432	1714	439864771	1644	proxy_output	1773993752
433	1714	439864771	1645	proxy_output	1773993753
434	1714	439864771	1646	proxy_output	1773993753
435	1734	1155492418	1658	proxy_output	1773994118
436	1734	1155492418	1659	proxy_output	1773994118
437	1734	1155492418	1660	proxy_output	1773994118
438	1742	2018560243	1666	proxy_output	1773994438
439	1742	2018560243	1667	proxy_output	1773994438
440	1742	2018560243	1668	proxy_output	1773994438
441	1749	646448570	1687	proxy_output	1773994653
442	1749	646448570	1688	proxy_output	1773994653
443	1749	646448570	1689	proxy_output	1773994653
758	2188	931533618	2478	proxy_output	1774528887
759	2188	931533618	2479	proxy_output	1774528887
760	2203	5162190458	2489	proxy_output	1774533146
761	2203	5162190458	2490	proxy_output	1774533146
762	2203	5162190458	2491	proxy_output	1774533147
769	1544	794762280	2511	proxy_output	1774534140
770	1544	794762280	2512	proxy_output	1774534140
771	1143	1076638199	2521	proxy_output	1774537204
458	1729	877080718	1721	proxy_output	1773995199
459	1729	877080718	1722	proxy_output	1773995199
460	1729	877080718	1723	proxy_output	1773995199
461	1752	599576469	1725	proxy_output	1773995261
462	1752	599576469	1726	proxy_output	1773995261
463	1752	599576469	1727	proxy_output	1773995261
772	1143	1076638199	2522	proxy_output	1774537204
773	1143	1076638199	2523	proxy_output	1774537205
774	296	853700754	2539	proxy_output	1774539290
775	296	853700754	2540	proxy_output	1774539290
776	296	853700754	2541	proxy_output	1774539290
949	11	558396308	2792	proxy_output	1774648795
950	11	558396308	2793	proxy_output	1774648796
779	1149	737412186	2552	proxy_output	1774545023
780	1149	737412186	2553	proxy_output	1774545023
781	1149	737412186	2554	proxy_output	1774545023
782	1638	519070845	2556	proxy_output	1774545476
783	1638	519070845	2557	proxy_output	1774545476
784	1154	861362028	2567	proxy_output	1774547187
785	1154	861362028	2568	proxy_output	1774547187
786	1154	861362028	2569	proxy_output	1774547187
464	1788	8340058151	1737	proxy_output	1773996005
465	1788	8340058151	1738	proxy_output	1773996005
466	1751	1356844692	1740	proxy_output	1773996752
467	1751	1356844692	1741	proxy_output	1773996752
468	1751	1356844692	1742	proxy_output	1773996752
471	1798	628629925	1762	proxy_output	1774005443
472	1798	628629925	1763	proxy_output	1774005444
473	1798	628629925	1764	proxy_output	1774005444
474	1813	742792937	1774	proxy_output	1774010281
475	1813	742792937	1775	proxy_output	1774010281
476	1813	742792937	1776	proxy_output	1774010281
732	2159	801994452	2414	proxy_output	1774457850
733	2159	801994452	2415	proxy_output	1774457850
734	2159	801994452	2416	proxy_output	1774457850
737	2176	2107029852	2433	proxy_output	1774496378
738	2176	2107029852	2434	proxy_output	1774496378
739	2176	2107029852	2435	proxy_output	1774496378
501	1861	1987030973	1831	proxy_output	1774019689
502	1861	1987030973	1832	proxy_output	1774019689
503	1861	1987030973	1833	proxy_output	1774019690
504	1867	652916763	1839	proxy_output	1774020217
505	1867	652916763	1840	proxy_output	1774020217
506	1867	652916763	1841	proxy_output	1774020217
507	1867	652916763	1842	proxy_output	1774020217
508	1867	652916763	1843	proxy_output	1774020217
509	1867	652916763	1844	proxy_output	1774020218
510	1867	652916763	1845	proxy_output	1774020218
511	1874	621754429	1855	proxy_output	1774024091
512	1874	621754429	1856	proxy_output	1774024091
513	1874	621754429	1857	proxy_output	1774024091
514	1882	816537333	1866	proxy_output	1774078930
515	1882	816537333	1867	proxy_output	1774078930
516	1882	816537333	1868	proxy_output	1774078931
581	1952	1076136406	1989	proxy_output	1774158233
582	1952	1076136406	1990	proxy_output	1774158233
583	1952	1076136406	1991	proxy_output	1774158233
584	1952	1076136406	1992	proxy_output	1774158233
585	1952	1076136406	1993	proxy_output	1774158234
586	1952	1076136406	1994	proxy_output	1774158234
587	1952	1076136406	1995	proxy_output	1774158234
588	1952	1076136406	1996	proxy_output	1774158234
589	1952	1076136406	1997	proxy_output	1774158234
590	1952	1076136406	1998	proxy_output	1774158234
591	1952	1076136406	1999	proxy_output	1774158235
592	1952	1076136406	2000	proxy_output	1774158235
593	1952	1076136406	2001	proxy_output	1774158235
594	1952	1076136406	2002	proxy_output	1774158235
595	1952	1076136406	2003	proxy_output	1774158235
596	1952	1076136406	2004	proxy_output	1774158236
597	1952	1076136406	2005	proxy_output	1774158236
598	1203	459584886	2020	proxy_output	1774199162
599	1203	459584886	2021	proxy_output	1774199162
600	1203	459584886	2022	proxy_output	1774199162
622	1997	267983932	2069	proxy_output	1774253093
623	1997	267983932	2070	proxy_output	1774253093
624	1997	267983932	2071	proxy_output	1774253094
625	1556	2019379594	2075	proxy_output	1774257939
626	1556	2019379594	2076	proxy_output	1774257939
627	1556	2019379594	2077	proxy_output	1774257939
951	11	558396308	2794	proxy_output	1774648796
952	11	558396308	2795	proxy_output	1774648796
953	11	558396308	2796	proxy_output	1774648796
954	11	558396308	2797	proxy_output	1774648796
955	11	558396308	2798	proxy_output	1774648796
956	11	558396308	2799	proxy_output	1774648797
957	11	558396308	2800	proxy_output	1774648797
958	11	558396308	2801	proxy_output	1774648797
679	2043	1253811031	2168	proxy_output	1774346162
680	2043	1253811031	2169	proxy_output	1774346162
681	2043	1253811031	2170	proxy_output	1774346162
682	1713	5888026625	2265	proxy_output	1774350473
683	1713	5888026625	2266	proxy_output	1774350473
821	1	1924535035	2649	proxy_output	1774599843
822	1	1924535035	2650	proxy_output	1774599843
823	1	1924535035	2651	proxy_output	1774599844
824	1	1924535035	2652	proxy_output	1774599844
825	1	1924535035	2653	proxy_output	1774599844
826	1	1924535035	2654	proxy_output	1774599844
827	1	1924535035	2655	proxy_output	1774599844
828	1	1924535035	2656	proxy_output	1774599845
829	1	1924535035	2657	proxy_output	1774599845
830	1	1924535035	2658	proxy_output	1774599845
831	1	1924535035	2659	proxy_output	1774599845
832	1	1924535035	2660	proxy_output	1774599845
833	1	1924535035	2661	proxy_output	1774599846
834	1	1924535035	2662	proxy_output	1774599846
835	1	1924535035	2663	proxy_output	1774599846
836	1	1924535035	2664	proxy_output	1774599846
850	2094	352469442	2682	proxy_output	1774602533
851	2094	352469442	2683	proxy_output	1774602534
878	1395	275448300	2712	proxy_output	1774610062
879	1395	275448300	2713	proxy_output	1774610063
880	1395	275448300	2714	proxy_output	1774610063
881	1395	275448300	2715	proxy_output	1774610063
882	1395	275448300	2716	proxy_output	1774610063
883	1395	275448300	2717	proxy_output	1774610063
884	1395	275448300	2718	proxy_output	1774610063
885	1986	5135597375	2720	proxy_output	1774629979
886	1986	5135597375	2721	proxy_output	1774629980
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: proxybotuserrsuisuusus
--

COPY public.users (id, tg_user_id, username, first_name, last_name, created_at, updated_at) FROM stdin;
1544	794762280	liza_jewees	liz	\N	1773606492	1774534139
1584	979320559	peresmeshnitsa645	Александра	\N	1773682378	1773682812
1195	5416731973	\N	Dmitry	Usanov	1771948372	1771948491
767	1417827742	polinaus21	p	\N	1771938545	1771938619
1337	509553101	Dimon_Coin	Dmitriy	Poznyshev	1772093420	1773835663
1262	6648992884	CryptoCowboyCEO	CEO	\N	1771969350	1771969396
776	5285135313	\N	Людмила	\N	1771939191	1771939390
1265	6771629560	CEOCryptoCowboy	COO	\N	1771969441	1771969441
1149	737412186	chhiichh	Элюс💪🏼🎀	\N	1771944742	1774545022
1203	459584886	Sopha079	София	\N	1771948614	1774199161
296	853700754	xOlya0x	Оля	\N	1771911210	1774539290
1322	5510054910	alexouzell	alexouzell	\N	1772025682	1772025883
1798	628629925	Ananeva29	Настя	Ананьева	1774004986	1774005443
1874	621754429	Bessolova_Uliya_77	Юлия	\N	1774024027	1774024090
196	1088192644	\N	\N	\N	1771884746	1771884746
1143	1076638199	polina_nicheporchuk	Polisha	\N	1771944562	1774537205
1378	6037626594	flotskix	Максим	\N	1772179634	1772180042
1624	8618772238	\N	Petya	Rem	1773838164	1773838368
1161	1091492352	katedemidik	kate	\N	1771945118	1771945368
1568	89104148683	\N	\N	\N	1773658969	1773658969
1331	2043764535	\N	Дмитрий	\N	1772047480	1772047508
1761	686782813	anyasas_77	Hanna💛	\N	1773994744	1774546396
1226	1657709716	\N	Нина	Светлова	1771952010	1771952010
326	7176003171	IamtheCEO	CEO	\N	1771912403	1771934360
382	903449432	\N	Тарас	\N	1771924067	1771924135
1425	7370676742	indigo_inspire	Oleg	Li	1772399474	1772400705
1442	1151047728	iamvolk	Olga	Volk	1772401110	1772401110
1118	1243381783	SokolYanchikk	Яна	\N	1771943716	1771953921
1389	1290146931	steffochkal	stefa	\N	1772185969	1772186027
1181	1580415068	\N	Лариса	Романенко	1771947207	1771947207
393	374962741	Russkiyunder	Russkiy	Underground	1771928682	1771928902
1595	812966617	on1y_up	FIL	\N	1773688305	1773696018
1532	5334555411	strygwyr777	strygwyr77	\N	1773424545	1773424545
1230	266186319	Nikola_Moskovckii	Папа Коля	\N	1771953300	1772951944
1402	855402024	Sofiyka_abbas	Sofiyka	\N	1772199537	1772199537
1190	315610952	Tanya_Sarapkina	Tanya	Sarapkina	1771948043	1771948043
1445	665410048	dashotysh	Дарья	\N	1772558959	1772559043
1403	797204449	stsergeant106	Михаил	\N	1772310421	1772310433
1297	5207644213	dzhigalina	diana	\N	1772001044	1772001051
1702	553941277	Lamunchik	Lamunchik	\N	1773925034	1773925426
1298	5774369853	miasha025	Mia	\N	1772001045	1772001074
1350	262746320	\N	Макс	\N	1772122095	1772122264
1358	703749157	alxndrmikhailov	Alexandr	\N	1772139499	1772139499
1254	782071738	v_viktoriii12	Виктория	\N	1771963627	1771963627
1172	64504614	Sashenka_s05	Sasha	\N	1771946571	1772367887
1557	667253174	marinaRadi	Marina	\N	1773658854	1773659108
1533	8423198471	\N	dpso	fidisj	1773505476	1773505494
775	1144391790	Salma_Zakirova	Salma	\N	1771938983	1772011838
1453	6048846195	\N	Young	\N	1772620529	1772620691
1459	1124134462	abr_nikitayashin	Никита	импорт авто АБР	1772710618	1772710618
1460	961773714	zhilenkoww	Илья	Жиленков	1772710825	1772710825
1135	854988710	bonitas3	Igor	Ermilov	1771944254	1773779233
1776	1258604084	\N	Varya	\N	1773995146	1774016984
1749	646448570	\N	K.N	\N	1773994569	1773994653
1211	8465752276	TeleProx_Help	TeleProx Help	\N	1771949523	1774368504
1734	1155492418	\N	катюха	\N	1773993946	1773994117
1607	5107389209	goncharovaa19	Анна	\N	1773779199	1773779315
1638	519070845	msk_redhead	Anastasiia	\N	1773912184	1774545475
1644	720204235	yrez89	Юрий Крысов	\N	1773912223	1773918583
1729	877080718	Kama_13	Кама	\N	1773993917	1773995198
1555	385254261	Ksushepotkina	Kseniya	Pushkareva	1773653784	1773653784
1788	8340058151	DirtyCashIWantYou	CEO	\N	1773995919	1773996004
1714	439864771	akaratkevich	AK	\N	1773993663	1773993751
1882	816537333	lenka_0303	Elena Dmitrievna	\N	1774078821	1774078928
1154	861362028	tsaaaana	Нюта	\N	1771944766	1774547185
1751	1356844692	Valli131	D	\N	1773994588	1773996752
1742	2018560243	\N	Maria	Galay	1773994180	1773994437
1750	5385576178	zeljkab	Zeljka	Belovan	1773994570	1773994570
1752	599576469	shlapakn	Анастасия	Шлапакова	1773994598	1773995260
1556	2019379594	MH_account	Milana	\N	1773653851	1774257937
1804	5117189577	mixxzl9	足球	\N	1774005101	1774005121
1813	742792937	\N	Dani🎭	\N	1774010194	1774010280
1492	795925664	alfatnns	K	\N	1773085250	1774111685
1843	983607854	\N	Anastasia	Kovaleva	1774016074	1774016108
1867	652916763	frutella03	Juli	\N	1774020130	1774020216
1873	7568974318	\N	Berivan	İçen	1774021827	1774021827
1861	1987030973	\N	Khanova Arina	\N	1774019606	1774019688
1897	878142505	Elena9_0	Elena	\N	1774086476	1774118318
1892	1062850605	SHAenaea	Лена	\N	1774085144	1774085268
1903	366906750	\N	Вячеслав	\N	1774088523	1774088618
1910	5157451253	\N	Диана	\N	1774102163	1774102667
1919	2008952492	iint22	Карен	Григориевич	1774105394	1774105402
1713	5888026625	msaleksseevna	Maria	Alexeevna	1773993659	1774109679
1938	936367944	vrulissss	Lll	\N	1774129913	1774372416
1952	1076136406	pavlovnaj	J.P.	\N	1774158132	1774158232
1462	5469749689	alx_mmgc	magic	\N	1772712890	1774555520
1997	267983932	\N	Вадим	Озеров ;-)	1774252418	1774253092
2043	1253811031	bless_y0	Юна	Блэсс	1774346130	1774346162
2070	891958199	tusha111111	Екатерина Вельдяскина	\N	1774356752	1774356839
2098	1246575365	yourshurochka	Шура	Черкасова	1774381117	1774381368
2142	1904248886	yulia020782	Yulia	\N	1774450265	1774450335
2094	352469442	\N	Vladimir	Rudnitskiy	1774372381	1774602533
1395	275448300	whenth3	whenth3	\N	1772186120	1774610061
1986	5135597375	valeriaburia	Valeria	Buriachenko	1774252138	1774629979
11	558396308	Temich55	Temich	\N	1771856747	1774648795
2159	801994452	zzavalnayaa	Anna	\N	1774456259	1774457850
2176	2107029852	\N	F	\N	1774496259	1774496378
2188	931533618	too_good_for_heaven	Sofi	\N	1774526740	1774528885
2203	5162190458	anyassbyu	ann	\N	1774533120	1774533146
1	1924535035	vovaww	Владимир	Бухарин	1771856727	1774649338
\.


--
-- Name: banned_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.banned_users_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.payments_id_seq', 202, true);


--
-- Name: proxy_delivery_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.proxy_delivery_logs_id_seq', 683, true);


--
-- Name: proxy_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.proxy_links_id_seq', 234, true);


--
-- Name: proxy_pool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.proxy_pool_id_seq', 45222573, true);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 102, true);


--
-- Name: user_temp_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.user_temp_messages_id_seq', 958, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: proxybotuserrsuisuusus
--

SELECT pg_catalog.setval('public.users_id_seq', 2370, true);


--
-- Name: banned_users banned_users_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.banned_users
    ADD CONSTRAINT banned_users_pkey PRIMARY KEY (id);


--
-- Name: banned_users banned_users_tg_user_id_key; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.banned_users
    ADD CONSTRAINT banned_users_tg_user_id_key UNIQUE (tg_user_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (code);


--
-- Name: proxy_delivery_logs proxy_delivery_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_delivery_logs
    ADD CONSTRAINT proxy_delivery_logs_pkey PRIMARY KEY (id);


--
-- Name: proxy_links proxy_links_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_links
    ADD CONSTRAINT proxy_links_pkey PRIMARY KEY (id);


--
-- Name: proxy_links proxy_links_token_key; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_links
    ADD CONSTRAINT proxy_links_token_key UNIQUE (token);


--
-- Name: proxy_pool proxy_pool_assigned_link_id_key; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_pool
    ADD CONSTRAINT proxy_pool_assigned_link_id_key UNIQUE (assigned_link_id);


--
-- Name: proxy_pool proxy_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_pool
    ADD CONSTRAINT proxy_pool_pkey PRIMARY KEY (id);


--
-- Name: proxy_pool proxy_pool_port_key; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_pool
    ADD CONSTRAINT proxy_pool_port_key UNIQUE (port);


--
-- Name: subscriptions subscriptions_payment_id_key; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_payment_id_key UNIQUE (payment_id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: user_temp_messages user_temp_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.user_temp_messages
    ADD CONSTRAINT user_temp_messages_pkey PRIMARY KEY (id);


--
-- Name: user_temp_messages user_temp_messages_user_id_message_id_kind_key; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.user_temp_messages
    ADD CONSTRAINT user_temp_messages_user_id_message_id_kind_key UNIQUE (user_id, message_id, kind);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_tg_user_id_key; Type: CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_tg_user_id_key UNIQUE (tg_user_id);


--
-- Name: idx_banned_users_tg_user_id; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_banned_users_tg_user_id ON public.banned_users USING btree (tg_user_id);


--
-- Name: idx_payments_user_status; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_payments_user_status ON public.payments USING btree (user_id, status);


--
-- Name: idx_payments_yookassa_payment_id; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE UNIQUE INDEX idx_payments_yookassa_payment_id ON public.payments USING btree (yookassa_payment_id) WHERE (yookassa_payment_id IS NOT NULL);


--
-- Name: idx_proxy_delivery_logs_proxy_link_id; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_proxy_delivery_logs_proxy_link_id ON public.proxy_delivery_logs USING btree (proxy_link_id);


--
-- Name: idx_proxy_delivery_logs_tg_user_id; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_proxy_delivery_logs_tg_user_id ON public.proxy_delivery_logs USING btree (tg_user_id);


--
-- Name: idx_proxy_links_expires_at; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_proxy_links_expires_at ON public.proxy_links USING btree (expires_at);


--
-- Name: idx_proxy_links_user_status; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_proxy_links_user_status ON public.proxy_links USING btree (user_id, status);


--
-- Name: idx_proxy_pool_status; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_proxy_pool_status ON public.proxy_pool USING btree (status);


--
-- Name: idx_subscriptions_expires_at; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_subscriptions_expires_at ON public.subscriptions USING btree (expires_at);


--
-- Name: idx_subscriptions_user_status; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_subscriptions_user_status ON public.subscriptions USING btree (user_id, status);


--
-- Name: idx_user_temp_messages_user_kind; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_user_temp_messages_user_kind ON public.user_temp_messages USING btree (user_id, kind);


--
-- Name: idx_users_tg_user_id; Type: INDEX; Schema: public; Owner: proxybotuserrsuisuusus
--

CREATE INDEX idx_users_tg_user_id ON public.users USING btree (tg_user_id);


--
-- Name: payments payments_plan_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_plan_code_fkey FOREIGN KEY (plan_code) REFERENCES public.plans(code);


--
-- Name: payments payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: proxy_delivery_logs proxy_delivery_logs_proxy_link_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_delivery_logs
    ADD CONSTRAINT proxy_delivery_logs_proxy_link_id_fkey FOREIGN KEY (proxy_link_id) REFERENCES public.proxy_links(id);


--
-- Name: proxy_delivery_logs proxy_delivery_logs_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_delivery_logs
    ADD CONSTRAINT proxy_delivery_logs_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id);


--
-- Name: proxy_delivery_logs proxy_delivery_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_delivery_logs
    ADD CONSTRAINT proxy_delivery_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: proxy_links proxy_links_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_links
    ADD CONSTRAINT proxy_links_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.subscriptions(id);


--
-- Name: proxy_links proxy_links_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_links
    ADD CONSTRAINT proxy_links_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: proxy_pool proxy_pool_assigned_link_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.proxy_pool
    ADD CONSTRAINT proxy_pool_assigned_link_id_fkey FOREIGN KEY (assigned_link_id) REFERENCES public.proxy_links(id);


--
-- Name: subscriptions subscriptions_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payments(id);


--
-- Name: subscriptions subscriptions_plan_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_plan_code_fkey FOREIGN KEY (plan_code) REFERENCES public.plans(code);


--
-- Name: subscriptions subscriptions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_temp_messages user_temp_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: proxybotuserrsuisuusus
--

ALTER TABLE ONLY public.user_temp_messages
    ADD CONSTRAINT user_temp_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 28oID2OwaKLQtNW7wFtvSF1dn4KnTayEF078uDxQ8pv2apJwvafSPcHdO4MpNbe

