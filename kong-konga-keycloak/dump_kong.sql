--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE "api-gw";




--
-- Drop roles
--

DROP ROLE kong;


--
-- Roles
--

CREATE ROLE kong;
ALTER ROLE kong WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5f10343d1dc8d44c8935b356aa3f8aae2';






--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: kong
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO kong;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: kong
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: kong
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: kong
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

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
-- Name: api-gw; Type: DATABASE; Schema: -; Owner: kong
--

CREATE DATABASE "api-gw" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE "api-gw" OWNER TO kong;

\connect -reuse-previous=on "dbname='api-gw'"

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
-- Name: sync_tags(); Type: FUNCTION; Schema: public; Owner: kong
--

CREATE FUNCTION public.sync_tags() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
          IF (TG_OP = 'TRUNCATE') THEN
            DELETE FROM tags WHERE entity_name = TG_TABLE_NAME;
            RETURN NULL;
          ELSIF (TG_OP = 'DELETE') THEN
            DELETE FROM tags WHERE entity_id = OLD.id;
            RETURN OLD;
          ELSE

          -- Triggered by INSERT/UPDATE
          -- Do an upsert on the tags table
          -- So we don't need to migrate pre 1.1 entities
          INSERT INTO tags VALUES (NEW.id, TG_TABLE_NAME, NEW.tags)
          ON CONFLICT (entity_id) DO UPDATE
                  SET tags=EXCLUDED.tags;
          END IF;
          RETURN NEW;
        END;
      $$;


ALTER FUNCTION public.sync_tags() OWNER TO kong;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acls; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.acls (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    "group" text,
    cache_key text,
    tags text[]
);


ALTER TABLE public.acls OWNER TO kong;

--
-- Name: basicauth_credentials; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.basicauth_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    username text,
    password text,
    tags text[]
);


ALTER TABLE public.basicauth_credentials OWNER TO kong;

--
-- Name: ca_certificates; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.ca_certificates (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    cert text NOT NULL,
    tags text[]
);


ALTER TABLE public.ca_certificates OWNER TO kong;

--
-- Name: certificates; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.certificates (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    cert text,
    key text,
    tags text[]
);


ALTER TABLE public.certificates OWNER TO kong;

--
-- Name: cluster_events; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.cluster_events (
    id uuid NOT NULL,
    node_id uuid NOT NULL,
    at timestamp with time zone NOT NULL,
    nbf timestamp with time zone,
    expire_at timestamp with time zone NOT NULL,
    channel text,
    data text
);


ALTER TABLE public.cluster_events OWNER TO kong;

--
-- Name: consumers; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.consumers (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    username text,
    custom_id text,
    tags text[]
);


ALTER TABLE public.consumers OWNER TO kong;

--
-- Name: hmacauth_credentials; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.hmacauth_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    username text,
    secret text,
    tags text[]
);


ALTER TABLE public.hmacauth_credentials OWNER TO kong;

--
-- Name: jwt_secrets; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.jwt_secrets (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    key text,
    secret text,
    algorithm text,
    rsa_public_key text,
    tags text[]
);


ALTER TABLE public.jwt_secrets OWNER TO kong;

--
-- Name: keyauth_credentials; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.keyauth_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    consumer_id uuid,
    key text,
    tags text[],
    ttl timestamp with time zone
);


ALTER TABLE public.keyauth_credentials OWNER TO kong;

--
-- Name: konga_api_health_checks; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_api_health_checks (
    id integer NOT NULL,
    api_id text,
    api json,
    health_check_endpoint text,
    notification_endpoint text,
    active boolean,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_api_health_checks OWNER TO kong;

--
-- Name: konga_api_health_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_api_health_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_api_health_checks_id_seq OWNER TO kong;

--
-- Name: konga_api_health_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_api_health_checks_id_seq OWNED BY public.konga_api_health_checks.id;


--
-- Name: konga_email_transports; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_email_transports (
    id integer NOT NULL,
    name text,
    description text,
    schema json,
    settings json,
    active boolean,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_email_transports OWNER TO kong;

--
-- Name: konga_email_transports_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_email_transports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_email_transports_id_seq OWNER TO kong;

--
-- Name: konga_email_transports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_email_transports_id_seq OWNED BY public.konga_email_transports.id;


--
-- Name: konga_kong_nodes; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_kong_nodes (
    id integer NOT NULL,
    name text,
    type text,
    kong_admin_url text,
    netdata_url text,
    kong_api_key text,
    jwt_algorithm text,
    jwt_key text,
    jwt_secret text,
    kong_version text,
    health_checks boolean,
    health_check_details json,
    active boolean,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_nodes OWNER TO kong;

--
-- Name: konga_kong_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_kong_nodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_nodes_id_seq OWNER TO kong;

--
-- Name: konga_kong_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_kong_nodes_id_seq OWNED BY public.konga_kong_nodes.id;


--
-- Name: konga_kong_services; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_kong_services (
    id integer NOT NULL,
    service_id text,
    kong_node_id text,
    description text,
    tags json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_services OWNER TO kong;

--
-- Name: konga_kong_services_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_kong_services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_services_id_seq OWNER TO kong;

--
-- Name: konga_kong_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_kong_services_id_seq OWNED BY public.konga_kong_services.id;


--
-- Name: konga_kong_snapshot_schedules; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_kong_snapshot_schedules (
    id integer NOT NULL,
    connection integer,
    active boolean,
    cron text,
    "lastRunAt" date,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_snapshot_schedules OWNER TO kong;

--
-- Name: konga_kong_snapshot_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_kong_snapshot_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_snapshot_schedules_id_seq OWNER TO kong;

--
-- Name: konga_kong_snapshot_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_kong_snapshot_schedules_id_seq OWNED BY public.konga_kong_snapshot_schedules.id;


--
-- Name: konga_kong_snapshots; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_kong_snapshots (
    id integer NOT NULL,
    name text,
    kong_node_name text,
    kong_node_url text,
    kong_version text,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_snapshots OWNER TO kong;

--
-- Name: konga_kong_snapshots_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_kong_snapshots_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_snapshots_id_seq OWNER TO kong;

--
-- Name: konga_kong_snapshots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_kong_snapshots_id_seq OWNED BY public.konga_kong_snapshots.id;


--
-- Name: konga_kong_upstream_alerts; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_kong_upstream_alerts (
    id integer NOT NULL,
    upstream_id text,
    connection integer,
    email boolean,
    slack boolean,
    cron text,
    active boolean,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_kong_upstream_alerts OWNER TO kong;

--
-- Name: konga_kong_upstream_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_kong_upstream_alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_kong_upstream_alerts_id_seq OWNER TO kong;

--
-- Name: konga_kong_upstream_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_kong_upstream_alerts_id_seq OWNED BY public.konga_kong_upstream_alerts.id;


--
-- Name: konga_netdata_connections; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_netdata_connections (
    id integer NOT NULL,
    "apiId" text,
    url text,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_netdata_connections OWNER TO kong;

--
-- Name: konga_netdata_connections_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_netdata_connections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_netdata_connections_id_seq OWNER TO kong;

--
-- Name: konga_netdata_connections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_netdata_connections_id_seq OWNED BY public.konga_netdata_connections.id;


--
-- Name: konga_passports; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_passports (
    id integer NOT NULL,
    protocol text,
    password text,
    provider text,
    identifier text,
    tokens json,
    "user" integer,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.konga_passports OWNER TO kong;

--
-- Name: konga_passports_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_passports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_passports_id_seq OWNER TO kong;

--
-- Name: konga_passports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_passports_id_seq OWNED BY public.konga_passports.id;


--
-- Name: konga_settings; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_settings (
    id integer NOT NULL,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_settings OWNER TO kong;

--
-- Name: konga_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_settings_id_seq OWNER TO kong;

--
-- Name: konga_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_settings_id_seq OWNED BY public.konga_settings.id;


--
-- Name: konga_users; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.konga_users (
    id integer NOT NULL,
    username text,
    email text,
    "firstName" text,
    "lastName" text,
    admin boolean,
    node_id text,
    active boolean,
    "activationToken" text,
    node integer,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "createdUserId" integer,
    "updatedUserId" integer
);


ALTER TABLE public.konga_users OWNER TO kong;

--
-- Name: konga_users_id_seq; Type: SEQUENCE; Schema: public; Owner: kong
--

CREATE SEQUENCE public.konga_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.konga_users_id_seq OWNER TO kong;

--
-- Name: konga_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kong
--

ALTER SEQUENCE public.konga_users_id_seq OWNED BY public.konga_users.id;


--
-- Name: locks; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.locks (
    key text NOT NULL,
    owner text,
    ttl timestamp with time zone
);


ALTER TABLE public.locks OWNER TO kong;

--
-- Name: oauth2_authorization_codes; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.oauth2_authorization_codes (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    credential_id uuid,
    service_id uuid,
    code text,
    authenticated_userid text,
    scope text,
    ttl timestamp with time zone
);


ALTER TABLE public.oauth2_authorization_codes OWNER TO kong;

--
-- Name: oauth2_credentials; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.oauth2_credentials (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    name text,
    consumer_id uuid,
    client_id text,
    client_secret text,
    redirect_uris text[],
    tags text[]
);


ALTER TABLE public.oauth2_credentials OWNER TO kong;

--
-- Name: oauth2_tokens; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.oauth2_tokens (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    credential_id uuid,
    service_id uuid,
    access_token text,
    refresh_token text,
    token_type text,
    expires_in integer,
    authenticated_userid text,
    scope text,
    ttl timestamp with time zone
);


ALTER TABLE public.oauth2_tokens OWNER TO kong;

--
-- Name: plugins; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.plugins (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    name text NOT NULL,
    consumer_id uuid,
    service_id uuid,
    route_id uuid,
    config jsonb NOT NULL,
    enabled boolean NOT NULL,
    cache_key text,
    protocols text[],
    tags text[]
);


ALTER TABLE public.plugins OWNER TO kong;

--
-- Name: ratelimiting_metrics; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.ratelimiting_metrics (
    identifier text NOT NULL,
    period text NOT NULL,
    period_date timestamp with time zone NOT NULL,
    service_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    route_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    value integer
);


ALTER TABLE public.ratelimiting_metrics OWNER TO kong;

--
-- Name: response_ratelimiting_metrics; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.response_ratelimiting_metrics (
    identifier text NOT NULL,
    period text NOT NULL,
    period_date timestamp with time zone NOT NULL,
    service_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    route_id uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL,
    value integer
);


ALTER TABLE public.response_ratelimiting_metrics OWNER TO kong;

--
-- Name: routes; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.routes (
    id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name text,
    service_id uuid,
    protocols text[],
    methods text[],
    hosts text[],
    paths text[],
    snis text[],
    sources jsonb[],
    destinations jsonb[],
    regex_priority bigint,
    strip_path boolean,
    preserve_host boolean,
    tags text[],
    https_redirect_status_code integer,
    headers jsonb,
    path_handling text DEFAULT 'v0'::text
);


ALTER TABLE public.routes OWNER TO kong;

--
-- Name: schema_meta; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.schema_meta (
    key text NOT NULL,
    subsystem text NOT NULL,
    last_executed text,
    executed text[],
    pending text[]
);


ALTER TABLE public.schema_meta OWNER TO kong;

--
-- Name: services; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.services (
    id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name text,
    retries bigint,
    protocol text,
    host text,
    port bigint,
    path text,
    connect_timeout bigint,
    write_timeout bigint,
    read_timeout bigint,
    tags text[],
    client_certificate_id uuid
);


ALTER TABLE public.services OWNER TO kong;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.sessions (
    id uuid NOT NULL,
    session_id text,
    expires integer,
    data text,
    created_at timestamp with time zone,
    ttl timestamp with time zone
);


ALTER TABLE public.sessions OWNER TO kong;

--
-- Name: snis; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.snis (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(0)),
    name text NOT NULL,
    certificate_id uuid,
    tags text[]
);


ALTER TABLE public.snis OWNER TO kong;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.tags (
    entity_id uuid NOT NULL,
    entity_name text,
    tags text[]
);


ALTER TABLE public.tags OWNER TO kong;

--
-- Name: targets; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.targets (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)),
    upstream_id uuid,
    target text NOT NULL,
    weight integer NOT NULL,
    tags text[]
);


ALTER TABLE public.targets OWNER TO kong;

--
-- Name: ttls; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.ttls (
    primary_key_value text NOT NULL,
    primary_uuid_value uuid,
    table_name text NOT NULL,
    primary_key_name text NOT NULL,
    expire_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ttls OWNER TO kong;

--
-- Name: upstreams; Type: TABLE; Schema: public; Owner: kong
--

CREATE TABLE public.upstreams (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('UTC'::text, CURRENT_TIMESTAMP(3)),
    name text,
    hash_on text,
    hash_fallback text,
    hash_on_header text,
    hash_fallback_header text,
    hash_on_cookie text,
    hash_on_cookie_path text,
    slots integer NOT NULL,
    healthchecks jsonb,
    tags text[],
    algorithm text,
    host_header text
);


ALTER TABLE public.upstreams OWNER TO kong;

--
-- Name: konga_api_health_checks id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_api_health_checks ALTER COLUMN id SET DEFAULT nextval('public.konga_api_health_checks_id_seq'::regclass);


--
-- Name: konga_email_transports id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_email_transports ALTER COLUMN id SET DEFAULT nextval('public.konga_email_transports_id_seq'::regclass);


--
-- Name: konga_kong_nodes id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_nodes ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_nodes_id_seq'::regclass);


--
-- Name: konga_kong_services id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_services ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_services_id_seq'::regclass);


--
-- Name: konga_kong_snapshot_schedules id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_snapshot_schedules ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_snapshot_schedules_id_seq'::regclass);


--
-- Name: konga_kong_snapshots id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_snapshots ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_snapshots_id_seq'::regclass);


--
-- Name: konga_kong_upstream_alerts id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_upstream_alerts ALTER COLUMN id SET DEFAULT nextval('public.konga_kong_upstream_alerts_id_seq'::regclass);


--
-- Name: konga_netdata_connections id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_netdata_connections ALTER COLUMN id SET DEFAULT nextval('public.konga_netdata_connections_id_seq'::regclass);


--
-- Name: konga_passports id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_passports ALTER COLUMN id SET DEFAULT nextval('public.konga_passports_id_seq'::regclass);


--
-- Name: konga_settings id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_settings ALTER COLUMN id SET DEFAULT nextval('public.konga_settings_id_seq'::regclass);


--
-- Name: konga_users id; Type: DEFAULT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_users ALTER COLUMN id SET DEFAULT nextval('public.konga_users_id_seq'::regclass);


--
-- Data for Name: acls; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.acls (id, created_at, consumer_id, "group", cache_key, tags) FROM stdin;
\.


--
-- Data for Name: basicauth_credentials; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.basicauth_credentials (id, created_at, consumer_id, username, password, tags) FROM stdin;
\.


--
-- Data for Name: ca_certificates; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.ca_certificates (id, created_at, cert, tags) FROM stdin;
\.


--
-- Data for Name: certificates; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.certificates (id, created_at, cert, key, tags) FROM stdin;
\.


--
-- Data for Name: cluster_events; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.cluster_events (id, node_id, at, nbf, expire_at, channel, data) FROM stdin;
\.


--
-- Data for Name: consumers; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.consumers (id, created_at, username, custom_id, tags) FROM stdin;
\.


--
-- Data for Name: hmacauth_credentials; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.hmacauth_credentials (id, created_at, consumer_id, username, secret, tags) FROM stdin;
\.


--
-- Data for Name: jwt_secrets; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.jwt_secrets (id, created_at, consumer_id, key, secret, algorithm, rsa_public_key, tags) FROM stdin;
\.


--
-- Data for Name: keyauth_credentials; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.keyauth_credentials (id, created_at, consumer_id, key, tags, ttl) FROM stdin;
\.


--
-- Data for Name: konga_api_health_checks; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_api_health_checks (id, api_id, api, health_check_endpoint, notification_endpoint, active, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_email_transports; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_email_transports (id, name, description, schema, settings, active, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	smtp	Send emails using the SMTP protocol	[{"name":"host","description":"The SMTP host","type":"text","required":true},{"name":"port","description":"The SMTP port","type":"text","required":true},{"name":"username","model":"auth.user","description":"The SMTP user username","type":"text","required":true},{"name":"password","model":"auth.pass","description":"The SMTP user password","type":"text","required":true},{"name":"secure","model":"secure","description":"Use secure connection","type":"boolean"}]	{"host":"","port":"","auth":{"user":"","pass":""},"secure":false}	t	2020-03-24 12:46:54+00	2020-05-12 22:52:24+00	\N	\N
2	sendmail	Pipe messages to the sendmail command	\N	{"sendmail":true}	f	2020-03-24 12:46:54+00	2020-05-12 22:52:24+00	\N	\N
3	mailgun	Send emails through Mailgun’s Web API	[{"name":"api_key","model":"auth.api_key","description":"The API key that you got from www.mailgun.com/cp","type":"text","required":true},{"name":"domain","model":"auth.domain","description":"One of your domain names listed at your https://mailgun.com/app/domains","type":"text","required":true}]	{"auth":{"api_key":"","domain":""}}	f	2020-03-24 12:46:54+00	2020-05-12 22:52:24+00	\N	\N
\.


--
-- Data for Name: konga_kong_nodes; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_kong_nodes (id, name, type, kong_admin_url, netdata_url, kong_api_key, jwt_algorithm, jwt_key, jwt_secret, kong_version, health_checks, health_check_details, active, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	kong	default	http://kong:8001	\N		HS256	\N	\N	2.0.0	f	\N	f	2020-03-24 12:48:43+00	2020-03-24 12:48:43+00	1	1
\.


--
-- Data for Name: konga_kong_services; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_kong_services (id, service_id, kong_node_id, description, tags, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	6caa5d11-99bb-4db7-aa48-e7938857e3df	1	Mock service	\N	2020-03-24 12:57:30+00	2020-03-24 13:38:12+00	\N	\N
2	323e458d-2bff-45ff-8eb0-8170801c07ed	1	\N	\N	2020-04-26 13:36:23+00	2020-04-26 14:09:48+00	\N	\N
\.


--
-- Data for Name: konga_kong_snapshot_schedules; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_kong_snapshot_schedules (id, connection, active, cron, "lastRunAt", "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_kong_snapshots; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_kong_snapshots (id, name, kong_node_name, kong_node_url, kong_version, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	setup	kong	http://kong:8001	2.0.0	{"services":[{"host":"mockbin.org","created_at":1585054650,"connect_timeout":60000,"id":"6caa5d11-99bb-4db7-aa48-e7938857e3df","protocol":"http","name":"example-service","read_timeout":60000,"port":80,"path":"/request","updated_at":1585057092,"retries":5,"write_timeout":60000,"tags":[],"client_certificate":null,"extras":{"id":1,"service_id":"6caa5d11-99bb-4db7-aa48-e7938857e3df","kong_node_id":"1","description":"Mock service","tags":null,"createdAt":"2020-03-24T12:57:30.000Z","updatedAt":"2020-03-24T13:38:12.000Z","createdUser":null,"updatedUser":null}},{"host":"192.168.99.106","created_at":1585663360,"connect_timeout":60000,"id":"73a4a292-6706-47be-a74c-5414dc3d6538","protocol":"http","name":"fastapi-service","read_timeout":60000,"port":5000,"path":null,"updated_at":1585663360,"retries":5,"write_timeout":60000,"tags":null,"client_certificate":null,"extras":{}}],"routes":[{"id":"098bf4de-3779-4c87-9588-8a6f9f702d2b","path_handling":"v0","paths":["/fastapi"],"destinations":null,"headers":null,"protocols":["http","https"],"methods":["POST","PUT","PATCH","DELETE"],"snis":null,"service":{"id":"73a4a292-6706-47be-a74c-5414dc3d6538"},"name":null,"strip_path":true,"preserve_host":false,"regex_priority":0,"updated_at":1585663638,"sources":null,"hosts":null,"https_redirect_status_code":426,"tags":null,"created_at":1585663638},{"id":"729b06ac-e724-4a92-a8ee-bd8b26c5a9d7","path_handling":"v0","paths":["/test"],"destinations":null,"headers":null,"protocols":["http","https"],"methods":null,"snis":null,"service":{"id":"6caa5d11-99bb-4db7-aa48-e7938857e3df"},"name":null,"strip_path":true,"preserve_host":false,"regex_priority":0,"updated_at":1585055072,"sources":null,"hosts":null,"https_redirect_status_code":426,"tags":null,"created_at":1585055072},{"id":"c6e643ad-e468-4ecc-8850-e642f95edd32","path_handling":"v0","paths":["/fastapi"],"destinations":null,"headers":null,"protocols":["http","https"],"methods":["GET"],"snis":null,"service":{"id":"73a4a292-6706-47be-a74c-5414dc3d6538"},"name":null,"strip_path":true,"preserve_host":false,"regex_priority":0,"updated_at":1585663571,"sources":null,"hosts":null,"https_redirect_status_code":426,"tags":null,"created_at":1585663571}],"consumers":[],"plugins":[{"created_at":1585058868,"config":{"response_type":"code","introspection_endpoint":"192.168.99.106:8180/auth/realms/test/protocol/openid-connect/token/introspect","filters":null,"bearer_only":"no","ssl_verify":"no","session_secret":null,"introspection_endpoint_auth_method":null,"realm":"test","redirect_after_logout_uri":"/","scope":"openid","token_endpoint_auth_method":"client_secret_post","logout_path":"/logout","client_id":"kong","client_secret":"4cd2e98f-df15-4972-84c8-1be974e9aba6","discovery":"http://192.168.99.106:8180/auth/realms/test/.well-known/openid-configuration","recovery_page_path":null,"redirect_uri_path":null},"id":"33142505-dfc6-4ede-9d0c-a002b528edab","service":null,"enabled":true,"protocols":["grpc","grpcs","http","https"],"name":"oidc","consumer":null,"route":null,"tags":null},{"created_at":1585665565,"config":{"request_method":["GET","HEAD"],"cache_control":false,"vary_query_params":null,"storage_ttl":null,"response_code":[200,301,404],"cache_ttl":300,"vary_headers":null,"strategy":"memory","content_type":["text/plain","application/json"],"memory":{"dictionary_name":"kong_db_cache"}},"id":"7aa21e8f-57a7-4c3c-babc-55e8485e81a1","service":{"id":"73a4a292-6706-47be-a74c-5414dc3d6538"},"enabled":true,"protocols":["grpc","grpcs","http","https"],"name":"proxy-cache","consumer":null,"route":null,"tags":null}],"acls":[],"upstreams":[],"certificates":[],"snis":[]}	2020-03-31 16:29:38+00	2020-03-31 16:29:38+00	\N	\N
\.


--
-- Data for Name: konga_kong_upstream_alerts; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_kong_upstream_alerts (id, upstream_id, connection, email, slack, cron, active, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_netdata_connections; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_netdata_connections (id, "apiId", url, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
\.


--
-- Data for Name: konga_passports; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_passports (id, protocol, password, provider, identifier, tokens, "user", "createdAt", "updatedAt") FROM stdin;
1	local	$2a$10$8MYAhHWXWl.uLd8U5QdYEeDZumcJdAzCRhAd052bZec2JTJY7JGMC	\N	\N	\N	1	2020-03-24 12:47:53+00	2020-03-24 12:47:53+00
\.


--
-- Data for Name: konga_settings; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_settings (id, data, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	{"signup_enable":false,"signup_require_activation":false,"info_polling_interval":5000,"email_default_sender_name":"KONGA","email_default_sender":"konga@konga.test","email_notifications":false,"default_transport":"sendmail","notify_when":{"node_down":{"title":"A node is down or unresponsive","description":"Health checks must be enabled for the nodes that need to be monitored.","active":false},"api_down":{"title":"An API is down or unresponsive","description":"Health checks must be enabled for the APIs that need to be monitored.","active":false}},"integrations":[{"id":"slack","name":"Slack","image":"slack_rgb.png","config":{"enabled":false,"fields":[{"id":"slack_webhook_url","name":"Slack Webhook URL","type":"text","required":true,"value":""}],"slack_webhook_url":""}}],"user_permissions":{"apis":{"create":false,"read":true,"update":false,"delete":false},"services":{"create":false,"read":true,"update":false,"delete":false},"routes":{"create":false,"read":true,"update":false,"delete":false},"consumers":{"create":false,"read":true,"update":false,"delete":false},"plugins":{"create":false,"read":true,"update":false,"delete":false},"upstreams":{"create":false,"read":true,"update":false,"delete":false},"certificates":{"create":false,"read":true,"update":false,"delete":false},"connections":{"create":false,"read":true,"update":false,"delete":false},"users":{"create":false,"read":true,"update":false,"delete":false}}}	2020-03-24 12:46:54+00	2020-05-12 22:52:24+00	\N	\N
\.


--
-- Data for Name: konga_users; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.konga_users (id, username, email, "firstName", "lastName", admin, node_id, active, "activationToken", node, "createdAt", "updatedAt", "createdUserId", "updatedUserId") FROM stdin;
1	admin	dimoski.b98@gmail.com	\N	\N	t		t	f6329e00-cfe7-4824-b896-86ceddea32d7	1	2020-03-24 12:47:53+00	2020-03-24 12:48:44+00	\N	1
\.


--
-- Data for Name: locks; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.locks (key, owner, ttl) FROM stdin;
\.


--
-- Data for Name: oauth2_authorization_codes; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.oauth2_authorization_codes (id, created_at, credential_id, service_id, code, authenticated_userid, scope, ttl) FROM stdin;
\.


--
-- Data for Name: oauth2_credentials; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.oauth2_credentials (id, created_at, name, consumer_id, client_id, client_secret, redirect_uris, tags) FROM stdin;
\.


--
-- Data for Name: oauth2_tokens; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.oauth2_tokens (id, created_at, credential_id, service_id, access_token, refresh_token, token_type, expires_in, authenticated_userid, scope, ttl) FROM stdin;
\.


--
-- Data for Name: plugins; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.plugins (id, created_at, name, consumer_id, service_id, route_id, config, enabled, cache_key, protocols, tags) FROM stdin;
7aa21e8f-57a7-4c3c-babc-55e8485e81a1	2020-03-31 14:39:25+00	proxy-cache	\N	73a4a292-6706-47be-a74c-5414dc3d6538	\N	{"memory": {"dictionary_name": "kong_db_cache"}, "strategy": "memory", "cache_ttl": 300, "storage_ttl": null, "content_type": ["text/plain", "application/json"], "vary_headers": null, "cache_control": false, "response_code": [200, 301, 404], "request_method": ["GET", "HEAD"], "vary_query_params": null}	t	plugins:proxy-cache::73a4a292-6706-47be-a74c-5414dc3d6538::	{grpc,grpcs,http,https}	\N
5d0c63e0-0087-4025-8202-b6030ec8c05b	2020-04-14 00:40:00+00	oidc	\N	\N	\N	{"realm": "test", "scope": "openid", "filters": null, "timeout": null, "client_id": "kong", "discovery": "http://192.168.99.106:8180/auth/realms/test/.well-known/openid-configuration", "ssl_verify": "no", "bearer_only": "no", "logout_path": "/logout", "client_secret": "4cd2e98f-df15-4972-84c8-1be974e9aba6", "response_type": "code", "unauth_action": "auth", "session_secret": null, "redirect_uri_path": null, "recovery_page_path": null, "ignore_auth_filters": "", "id_token_header_name": "X-ID-Token", "userinfo_header_name": "X-USERINFO", "access_token_as_bearer": "yes", "introspection_endpoint": "http://192.168.99.106:8180/auth/realms/test/protocol/openid-connect/token/introspect", "disable_id_token_header": "no", "disable_userinfo_header": "no", "revoke_tokens_on_logout": "yes", "access_token_header_name": "Authorization", "redirect_after_logout_uri": "/", "token_endpoint_auth_method": "client_secret_post", "disable_access_token_header": "no", "introspection_endpoint_auth_method": null}	f	plugins:oidc::::	{grpc,grpcs,http,https}	\N
1375ed0f-a210-493c-9af8-06fcf2184353	2020-05-03 13:58:07+00	cookies-to-headers	\N	\N	\N	{"cookie_name": "Authorization"}	t	plugins:cookies-to-headers::::	{grpc,grpcs,http,https}	\N
de00c863-34d3-48d0-9541-8f77cd0f3a90	2020-04-26 14:05:46+00	oidc	\N	73a4a292-6706-47be-a74c-5414dc3d6538	\N	{"realm": "test", "scope": "openid", "filters": null, "timeout": null, "client_id": "kong", "discovery": "http://192.168.99.106:8180/auth/realms/test/.well-known/openid-configuration", "ssl_verify": "no", "bearer_only": "no", "logout_path": "/logout", "client_secret": "4cd2e98f-df15-4972-84c8-1be974e9aba6", "response_type": "code", "unauth_action": "auth", "session_secret": null, "redirect_uri_path": "/users/auth", "recovery_page_path": null, "ignore_auth_filters": "", "id_token_header_name": "X-ID-Token", "userinfo_header_name": "X-USERINFO", "access_token_as_bearer": "no", "introspection_endpoint": "http://192.168.99.106:8180/auth/realms/test/protocol/openid-connect/token/introspect", "disable_id_token_header": "no", "disable_userinfo_header": "no", "revoke_tokens_on_logout": "no", "access_token_header_name": "X-Access-Token", "redirect_after_logout_uri": "/", "token_endpoint_auth_method": "client_secret_post", "disable_access_token_header": "no", "introspection_endpoint_auth_method": null}	t	plugins:oidc::73a4a292-6706-47be-a74c-5414dc3d6538::	{grpc,grpcs,http,https}	\N
\.


--
-- Data for Name: ratelimiting_metrics; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.ratelimiting_metrics (identifier, period, period_date, service_id, route_id, value) FROM stdin;
\.


--
-- Data for Name: response_ratelimiting_metrics; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.response_ratelimiting_metrics (identifier, period, period_date, service_id, route_id, value) FROM stdin;
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.routes (id, created_at, updated_at, name, service_id, protocols, methods, hosts, paths, snis, sources, destinations, regex_priority, strip_path, preserve_host, tags, https_redirect_status_code, headers, path_handling) FROM stdin;
729b06ac-e724-4a92-a8ee-bd8b26c5a9d7	2020-03-24 13:04:32+00	2020-03-24 13:04:32+00	\N	6caa5d11-99bb-4db7-aa48-e7938857e3df	{http,https}	\N	\N	{/test}	\N	\N	\N	0	t	f	\N	426	\N	v0
c6e643ad-e468-4ecc-8850-e642f95edd32	2020-03-31 14:06:11+00	2020-03-31 14:06:11+00	\N	73a4a292-6706-47be-a74c-5414dc3d6538	{http,https}	{GET}	\N	{/fastapi}	\N	\N	\N	0	t	f	\N	426	\N	v0
098bf4de-3779-4c87-9588-8a6f9f702d2b	2020-03-31 14:07:18+00	2020-03-31 14:07:18+00	\N	73a4a292-6706-47be-a74c-5414dc3d6538	{http,https}	{POST,PUT,PATCH,DELETE}	\N	{/fastapi}	\N	\N	\N	0	t	f	\N	426	\N	v0
5467e2dc-c969-45a5-87df-4ea2533b80fa	2020-04-26 13:36:56+00	2020-05-03 20:20:15+00	\N	323e458d-2bff-45ff-8eb0-8170801c07ed	{http,https}	{GET,POST}	{}	{/}	\N	\N	\N	0	t	f	\N	426	\N	v0
\.


--
-- Data for Name: schema_meta; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.schema_meta (key, subsystem, last_executed, executed, pending) FROM stdin;
schema_meta	core	008_150_to_200	{000_base,003_100_to_110,004_110_to_120,005_120_to_130,006_130_to_140,007_140_to_150,008_150_to_200}	{}
schema_meta	hmac-auth	002_130_to_140	{000_base_hmac_auth,002_130_to_140}	\N
schema_meta	oauth2	003_130_to_140	{000_base_oauth2,003_130_to_140}	\N
schema_meta	jwt	002_130_to_140	{000_base_jwt,002_130_to_140}	\N
schema_meta	basic-auth	002_130_to_140	{000_base_basic_auth,002_130_to_140}	\N
schema_meta	key-auth	002_130_to_140	{000_base_key_auth,002_130_to_140}	\N
schema_meta	acl	002_130_to_140	{000_base_acl,002_130_to_140}	\N
schema_meta	session	000_base_session	{000_base_session}	\N
schema_meta	response-ratelimiting	000_base_response_rate_limiting	{000_base_response_rate_limiting}	\N
schema_meta	rate-limiting	003_10_to_112	{000_base_rate_limiting,003_10_to_112}	\N
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.services (id, created_at, updated_at, name, retries, protocol, host, port, path, connect_timeout, write_timeout, read_timeout, tags, client_certificate_id) FROM stdin;
6caa5d11-99bb-4db7-aa48-e7938857e3df	2020-03-24 12:57:30+00	2020-03-24 13:38:12+00	example-service	5	http	mockbin.org	80	/request	60000	60000	60000	{}	\N
73a4a292-6706-47be-a74c-5414dc3d6538	2020-03-31 14:02:40+00	2020-03-31 14:02:40+00	fastapi-service	5	http	192.168.99.106	5000	\N	60000	60000	60000	\N	\N
323e458d-2bff-45ff-8eb0-8170801c07ed	2020-04-26 13:36:23+00	2020-04-26 14:09:48+00	users-service	5	http	192.168.99.106	3000	\N	60000	60000	60000	{}	\N
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.sessions (id, session_id, expires, data, created_at, ttl) FROM stdin;
\.


--
-- Data for Name: snis; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.snis (id, created_at, name, certificate_id, tags) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.tags (entity_id, entity_name, tags) FROM stdin;
729b06ac-e724-4a92-a8ee-bd8b26c5a9d7	routes	\N
6caa5d11-99bb-4db7-aa48-e7938857e3df	services	{}
1375ed0f-a210-493c-9af8-06fcf2184353	plugins	\N
73a4a292-6706-47be-a74c-5414dc3d6538	services	\N
c6e643ad-e468-4ecc-8850-e642f95edd32	routes	\N
098bf4de-3779-4c87-9588-8a6f9f702d2b	routes	\N
7aa21e8f-57a7-4c3c-babc-55e8485e81a1	plugins	\N
5467e2dc-c969-45a5-87df-4ea2533b80fa	routes	\N
de00c863-34d3-48d0-9541-8f77cd0f3a90	plugins	\N
5d0c63e0-0087-4025-8202-b6030ec8c05b	plugins	\N
323e458d-2bff-45ff-8eb0-8170801c07ed	services	{}
\.


--
-- Data for Name: targets; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.targets (id, created_at, upstream_id, target, weight, tags) FROM stdin;
\.


--
-- Data for Name: ttls; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.ttls (primary_key_value, primary_uuid_value, table_name, primary_key_name, expire_at) FROM stdin;
\.


--
-- Data for Name: upstreams; Type: TABLE DATA; Schema: public; Owner: kong
--

COPY public.upstreams (id, created_at, name, hash_on, hash_fallback, hash_on_header, hash_fallback_header, hash_on_cookie, hash_on_cookie_path, slots, healthchecks, tags, algorithm, host_header) FROM stdin;
\.


--
-- Name: konga_api_health_checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_api_health_checks_id_seq', 1, false);


--
-- Name: konga_email_transports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_email_transports_id_seq', 3, true);


--
-- Name: konga_kong_nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_kong_nodes_id_seq', 1, true);


--
-- Name: konga_kong_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_kong_services_id_seq', 2, true);


--
-- Name: konga_kong_snapshot_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_kong_snapshot_schedules_id_seq', 1, false);


--
-- Name: konga_kong_snapshots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_kong_snapshots_id_seq', 1, true);


--
-- Name: konga_kong_upstream_alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_kong_upstream_alerts_id_seq', 1, false);


--
-- Name: konga_netdata_connections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_netdata_connections_id_seq', 1, false);


--
-- Name: konga_passports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_passports_id_seq', 1, true);


--
-- Name: konga_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_settings_id_seq', 1, true);


--
-- Name: konga_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kong
--

SELECT pg_catalog.setval('public.konga_users_id_seq', 1, true);


--
-- Name: acls acls_cache_key_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_cache_key_key UNIQUE (cache_key);


--
-- Name: acls acls_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_pkey PRIMARY KEY (id);


--
-- Name: basicauth_credentials basicauth_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_pkey PRIMARY KEY (id);


--
-- Name: basicauth_credentials basicauth_credentials_username_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_username_key UNIQUE (username);


--
-- Name: ca_certificates ca_certificates_cert_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.ca_certificates
    ADD CONSTRAINT ca_certificates_cert_key UNIQUE (cert);


--
-- Name: ca_certificates ca_certificates_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.ca_certificates
    ADD CONSTRAINT ca_certificates_pkey PRIMARY KEY (id);


--
-- Name: certificates certificates_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT certificates_pkey PRIMARY KEY (id);


--
-- Name: cluster_events cluster_events_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.cluster_events
    ADD CONSTRAINT cluster_events_pkey PRIMARY KEY (id);


--
-- Name: consumers consumers_custom_id_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_custom_id_key UNIQUE (custom_id);


--
-- Name: consumers consumers_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_pkey PRIMARY KEY (id);


--
-- Name: consumers consumers_username_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.consumers
    ADD CONSTRAINT consumers_username_key UNIQUE (username);


--
-- Name: hmacauth_credentials hmacauth_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_pkey PRIMARY KEY (id);


--
-- Name: hmacauth_credentials hmacauth_credentials_username_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_username_key UNIQUE (username);


--
-- Name: jwt_secrets jwt_secrets_key_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_key_key UNIQUE (key);


--
-- Name: jwt_secrets jwt_secrets_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_pkey PRIMARY KEY (id);


--
-- Name: keyauth_credentials keyauth_credentials_key_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_key_key UNIQUE (key);


--
-- Name: keyauth_credentials keyauth_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_pkey PRIMARY KEY (id);


--
-- Name: konga_api_health_checks konga_api_health_checks_api_id_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_api_health_checks
    ADD CONSTRAINT konga_api_health_checks_api_id_key UNIQUE (api_id);


--
-- Name: konga_api_health_checks konga_api_health_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_api_health_checks
    ADD CONSTRAINT konga_api_health_checks_pkey PRIMARY KEY (id);


--
-- Name: konga_email_transports konga_email_transports_name_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_email_transports
    ADD CONSTRAINT konga_email_transports_name_key UNIQUE (name);


--
-- Name: konga_email_transports konga_email_transports_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_email_transports
    ADD CONSTRAINT konga_email_transports_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_nodes konga_kong_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_nodes
    ADD CONSTRAINT konga_kong_nodes_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_services konga_kong_services_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_services
    ADD CONSTRAINT konga_kong_services_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_services konga_kong_services_service_id_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_services
    ADD CONSTRAINT konga_kong_services_service_id_key UNIQUE (service_id);


--
-- Name: konga_kong_snapshot_schedules konga_kong_snapshot_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_snapshot_schedules
    ADD CONSTRAINT konga_kong_snapshot_schedules_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_snapshots konga_kong_snapshots_name_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_snapshots
    ADD CONSTRAINT konga_kong_snapshots_name_key UNIQUE (name);


--
-- Name: konga_kong_snapshots konga_kong_snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_snapshots
    ADD CONSTRAINT konga_kong_snapshots_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_upstream_alerts konga_kong_upstream_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_upstream_alerts
    ADD CONSTRAINT konga_kong_upstream_alerts_pkey PRIMARY KEY (id);


--
-- Name: konga_kong_upstream_alerts konga_kong_upstream_alerts_upstream_id_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_kong_upstream_alerts
    ADD CONSTRAINT konga_kong_upstream_alerts_upstream_id_key UNIQUE (upstream_id);


--
-- Name: konga_netdata_connections konga_netdata_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_netdata_connections
    ADD CONSTRAINT konga_netdata_connections_pkey PRIMARY KEY (id);


--
-- Name: konga_passports konga_passports_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_passports
    ADD CONSTRAINT konga_passports_pkey PRIMARY KEY (id);


--
-- Name: konga_settings konga_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_settings
    ADD CONSTRAINT konga_settings_pkey PRIMARY KEY (id);


--
-- Name: konga_users konga_users_email_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_users
    ADD CONSTRAINT konga_users_email_key UNIQUE (email);


--
-- Name: konga_users konga_users_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_users
    ADD CONSTRAINT konga_users_pkey PRIMARY KEY (id);


--
-- Name: konga_users konga_users_username_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.konga_users
    ADD CONSTRAINT konga_users_username_key UNIQUE (username);


--
-- Name: locks locks_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.locks
    ADD CONSTRAINT locks_pkey PRIMARY KEY (key);


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_code_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_code_key UNIQUE (code);


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_pkey PRIMARY KEY (id);


--
-- Name: oauth2_credentials oauth2_credentials_client_id_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_client_id_key UNIQUE (client_id);


--
-- Name: oauth2_credentials oauth2_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_pkey PRIMARY KEY (id);


--
-- Name: oauth2_tokens oauth2_tokens_access_token_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_access_token_key UNIQUE (access_token);


--
-- Name: oauth2_tokens oauth2_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth2_tokens oauth2_tokens_refresh_token_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_refresh_token_key UNIQUE (refresh_token);


--
-- Name: plugins plugins_cache_key_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_cache_key_key UNIQUE (cache_key);


--
-- Name: plugins plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_pkey PRIMARY KEY (id);


--
-- Name: ratelimiting_metrics ratelimiting_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.ratelimiting_metrics
    ADD CONSTRAINT ratelimiting_metrics_pkey PRIMARY KEY (identifier, period, period_date, service_id, route_id);


--
-- Name: response_ratelimiting_metrics response_ratelimiting_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.response_ratelimiting_metrics
    ADD CONSTRAINT response_ratelimiting_metrics_pkey PRIMARY KEY (identifier, period, period_date, service_id, route_id);


--
-- Name: routes routes_name_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_name_key UNIQUE (name);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: schema_meta schema_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.schema_meta
    ADD CONSTRAINT schema_meta_pkey PRIMARY KEY (key, subsystem);


--
-- Name: services services_name_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_name_key UNIQUE (name);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_session_id_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_session_id_key UNIQUE (session_id);


--
-- Name: snis snis_name_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_name_key UNIQUE (name);


--
-- Name: snis snis_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (entity_id);


--
-- Name: targets targets_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.targets
    ADD CONSTRAINT targets_pkey PRIMARY KEY (id);


--
-- Name: ttls ttls_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.ttls
    ADD CONSTRAINT ttls_pkey PRIMARY KEY (primary_key_value, table_name);


--
-- Name: upstreams upstreams_name_key; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.upstreams
    ADD CONSTRAINT upstreams_name_key UNIQUE (name);


--
-- Name: upstreams upstreams_pkey; Type: CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.upstreams
    ADD CONSTRAINT upstreams_pkey PRIMARY KEY (id);


--
-- Name: acls_consumer_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX acls_consumer_id_idx ON public.acls USING btree (consumer_id);


--
-- Name: acls_group_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX acls_group_idx ON public.acls USING btree ("group");


--
-- Name: acls_tags_idex_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX acls_tags_idex_tags_idx ON public.acls USING gin (tags);


--
-- Name: basicauth_consumer_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX basicauth_consumer_id_idx ON public.basicauth_credentials USING btree (consumer_id);


--
-- Name: basicauth_tags_idex_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX basicauth_tags_idex_tags_idx ON public.basicauth_credentials USING gin (tags);


--
-- Name: certificates_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX certificates_tags_idx ON public.certificates USING gin (tags);


--
-- Name: cluster_events_at_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX cluster_events_at_idx ON public.cluster_events USING btree (at);


--
-- Name: cluster_events_channel_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX cluster_events_channel_idx ON public.cluster_events USING btree (channel);


--
-- Name: cluster_events_expire_at_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX cluster_events_expire_at_idx ON public.cluster_events USING btree (expire_at);


--
-- Name: consumers_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX consumers_tags_idx ON public.consumers USING gin (tags);


--
-- Name: consumers_username_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX consumers_username_idx ON public.consumers USING btree (lower(username));


--
-- Name: hmacauth_credentials_consumer_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX hmacauth_credentials_consumer_id_idx ON public.hmacauth_credentials USING btree (consumer_id);


--
-- Name: hmacauth_tags_idex_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX hmacauth_tags_idex_tags_idx ON public.hmacauth_credentials USING gin (tags);


--
-- Name: jwt_secrets_consumer_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX jwt_secrets_consumer_id_idx ON public.jwt_secrets USING btree (consumer_id);


--
-- Name: jwt_secrets_secret_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX jwt_secrets_secret_idx ON public.jwt_secrets USING btree (secret);


--
-- Name: jwtsecrets_tags_idex_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX jwtsecrets_tags_idex_tags_idx ON public.jwt_secrets USING gin (tags);


--
-- Name: keyauth_credentials_consumer_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX keyauth_credentials_consumer_id_idx ON public.keyauth_credentials USING btree (consumer_id);


--
-- Name: keyauth_credentials_ttl_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX keyauth_credentials_ttl_idx ON public.keyauth_credentials USING btree (ttl);


--
-- Name: keyauth_tags_idex_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX keyauth_tags_idex_tags_idx ON public.keyauth_credentials USING gin (tags);


--
-- Name: locks_ttl_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX locks_ttl_idx ON public.locks USING btree (ttl);


--
-- Name: oauth2_authorization_codes_authenticated_userid_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_authorization_codes_authenticated_userid_idx ON public.oauth2_authorization_codes USING btree (authenticated_userid);


--
-- Name: oauth2_authorization_codes_ttl_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_authorization_codes_ttl_idx ON public.oauth2_authorization_codes USING btree (ttl);


--
-- Name: oauth2_authorization_credential_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_authorization_credential_id_idx ON public.oauth2_authorization_codes USING btree (credential_id);


--
-- Name: oauth2_authorization_service_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_authorization_service_id_idx ON public.oauth2_authorization_codes USING btree (service_id);


--
-- Name: oauth2_credentials_consumer_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_credentials_consumer_id_idx ON public.oauth2_credentials USING btree (consumer_id);


--
-- Name: oauth2_credentials_secret_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_credentials_secret_idx ON public.oauth2_credentials USING btree (client_secret);


--
-- Name: oauth2_credentials_tags_idex_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_credentials_tags_idex_tags_idx ON public.oauth2_credentials USING gin (tags);


--
-- Name: oauth2_tokens_authenticated_userid_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_tokens_authenticated_userid_idx ON public.oauth2_tokens USING btree (authenticated_userid);


--
-- Name: oauth2_tokens_credential_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_tokens_credential_id_idx ON public.oauth2_tokens USING btree (credential_id);


--
-- Name: oauth2_tokens_service_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_tokens_service_id_idx ON public.oauth2_tokens USING btree (service_id);


--
-- Name: oauth2_tokens_ttl_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX oauth2_tokens_ttl_idx ON public.oauth2_tokens USING btree (ttl);


--
-- Name: plugins_consumer_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX plugins_consumer_id_idx ON public.plugins USING btree (consumer_id);


--
-- Name: plugins_name_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX plugins_name_idx ON public.plugins USING btree (name);


--
-- Name: plugins_route_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX plugins_route_id_idx ON public.plugins USING btree (route_id);


--
-- Name: plugins_service_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX plugins_service_id_idx ON public.plugins USING btree (service_id);


--
-- Name: plugins_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX plugins_tags_idx ON public.plugins USING gin (tags);


--
-- Name: ratelimiting_metrics_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX ratelimiting_metrics_idx ON public.ratelimiting_metrics USING btree (service_id, route_id, period_date, period);


--
-- Name: routes_service_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX routes_service_id_idx ON public.routes USING btree (service_id);


--
-- Name: routes_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX routes_tags_idx ON public.routes USING gin (tags);


--
-- Name: services_fkey_client_certificate; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX services_fkey_client_certificate ON public.services USING btree (client_certificate_id);


--
-- Name: services_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX services_tags_idx ON public.services USING gin (tags);


--
-- Name: session_sessions_expires_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX session_sessions_expires_idx ON public.sessions USING btree (expires);


--
-- Name: snis_certificate_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX snis_certificate_id_idx ON public.snis USING btree (certificate_id);


--
-- Name: snis_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX snis_tags_idx ON public.snis USING gin (tags);


--
-- Name: tags_entity_name_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX tags_entity_name_idx ON public.tags USING btree (entity_name);


--
-- Name: tags_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX tags_tags_idx ON public.tags USING gin (tags);


--
-- Name: targets_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX targets_tags_idx ON public.targets USING gin (tags);


--
-- Name: targets_target_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX targets_target_idx ON public.targets USING btree (target);


--
-- Name: targets_upstream_id_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX targets_upstream_id_idx ON public.targets USING btree (upstream_id);


--
-- Name: ttls_primary_uuid_value_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX ttls_primary_uuid_value_idx ON public.ttls USING btree (primary_uuid_value);


--
-- Name: upstreams_tags_idx; Type: INDEX; Schema: public; Owner: kong
--

CREATE INDEX upstreams_tags_idx ON public.upstreams USING gin (tags);


--
-- Name: acls acls_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER acls_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.acls FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: basicauth_credentials basicauth_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER basicauth_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.basicauth_credentials FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: ca_certificates ca_certificates_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER ca_certificates_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.ca_certificates FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: certificates certificates_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER certificates_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.certificates FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: consumers consumers_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER consumers_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.consumers FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: hmacauth_credentials hmacauth_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER hmacauth_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.hmacauth_credentials FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: jwt_secrets jwtsecrets_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER jwtsecrets_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.jwt_secrets FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: keyauth_credentials keyauth_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER keyauth_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.keyauth_credentials FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: oauth2_credentials oauth2_credentials_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER oauth2_credentials_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.oauth2_credentials FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: plugins plugins_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER plugins_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.plugins FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: routes routes_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER routes_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.routes FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: services services_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER services_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.services FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: snis snis_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER snis_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.snis FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: targets targets_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER targets_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.targets FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: upstreams upstreams_sync_tags_trigger; Type: TRIGGER; Schema: public; Owner: kong
--

CREATE TRIGGER upstreams_sync_tags_trigger AFTER INSERT OR DELETE OR UPDATE OF tags ON public.upstreams FOR EACH ROW EXECUTE PROCEDURE public.sync_tags();


--
-- Name: acls acls_consumer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.acls
    ADD CONSTRAINT acls_consumer_id_fkey FOREIGN KEY (consumer_id) REFERENCES public.consumers(id) ON DELETE CASCADE;


--
-- Name: basicauth_credentials basicauth_credentials_consumer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.basicauth_credentials
    ADD CONSTRAINT basicauth_credentials_consumer_id_fkey FOREIGN KEY (consumer_id) REFERENCES public.consumers(id) ON DELETE CASCADE;


--
-- Name: hmacauth_credentials hmacauth_credentials_consumer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.hmacauth_credentials
    ADD CONSTRAINT hmacauth_credentials_consumer_id_fkey FOREIGN KEY (consumer_id) REFERENCES public.consumers(id) ON DELETE CASCADE;


--
-- Name: jwt_secrets jwt_secrets_consumer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.jwt_secrets
    ADD CONSTRAINT jwt_secrets_consumer_id_fkey FOREIGN KEY (consumer_id) REFERENCES public.consumers(id) ON DELETE CASCADE;


--
-- Name: keyauth_credentials keyauth_credentials_consumer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.keyauth_credentials
    ADD CONSTRAINT keyauth_credentials_consumer_id_fkey FOREIGN KEY (consumer_id) REFERENCES public.consumers(id) ON DELETE CASCADE;


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_credential_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_credential_id_fkey FOREIGN KEY (credential_id) REFERENCES public.oauth2_credentials(id) ON DELETE CASCADE;


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: oauth2_credentials oauth2_credentials_consumer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_credentials
    ADD CONSTRAINT oauth2_credentials_consumer_id_fkey FOREIGN KEY (consumer_id) REFERENCES public.consumers(id) ON DELETE CASCADE;


--
-- Name: oauth2_tokens oauth2_tokens_credential_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_credential_id_fkey FOREIGN KEY (credential_id) REFERENCES public.oauth2_credentials(id) ON DELETE CASCADE;


--
-- Name: oauth2_tokens oauth2_tokens_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: plugins plugins_consumer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_consumer_id_fkey FOREIGN KEY (consumer_id) REFERENCES public.consumers(id) ON DELETE CASCADE;


--
-- Name: plugins plugins_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(id) ON DELETE CASCADE;


--
-- Name: plugins plugins_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.plugins
    ADD CONSTRAINT plugins_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: routes routes_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: services services_client_certificate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_client_certificate_id_fkey FOREIGN KEY (client_certificate_id) REFERENCES public.certificates(id);


--
-- Name: snis snis_certificate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.snis
    ADD CONSTRAINT snis_certificate_id_fkey FOREIGN KEY (certificate_id) REFERENCES public.certificates(id);


--
-- Name: targets targets_upstream_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kong
--

ALTER TABLE ONLY public.targets
    ADD CONSTRAINT targets_upstream_id_fkey FOREIGN KEY (upstream_id) REFERENCES public.upstreams(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: kong
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO kong;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: kong
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

