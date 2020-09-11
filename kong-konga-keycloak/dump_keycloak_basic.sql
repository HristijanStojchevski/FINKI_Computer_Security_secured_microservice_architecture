--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE keycloak;




--
-- Drop roles
--

DROP ROLE keycloak;


--
-- Roles
--

CREATE ROLE keycloak;
ALTER ROLE keycloak WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md53665e4728566ea97857a44b3558b1426';






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
-- Name: template1; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO keycloak;

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: keycloak
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: keycloak
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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: keycloak
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
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO keycloak;

\connect keycloak

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

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(36) NOT NULL,
    requester character varying(36) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(36)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
1bbf642d-6b3c-43af-9790-1608634881c7	df81f3cf-7ab2-4ccc-81ad-629e1bd18607
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
d3972fc2-06ef-4301-ad14-da0c01357e98	\N	auth-cookie	master	aed1f280-a5a5-4922-af01-2d7041010485	2	10	f	\N	\N
0a6fb1b8-a06d-4d24-b8c3-76e084d665ad	\N	auth-spnego	master	aed1f280-a5a5-4922-af01-2d7041010485	3	20	f	\N	\N
99ec307a-b883-4305-9708-0e1a10274f0f	\N	identity-provider-redirector	master	aed1f280-a5a5-4922-af01-2d7041010485	2	25	f	\N	\N
27501b9d-3871-4dcb-9387-c2d6e8504732	\N	\N	master	aed1f280-a5a5-4922-af01-2d7041010485	2	30	t	754ef344-e3f3-4449-a562-0916e079d984	\N
d2952e24-7833-463e-a005-ba37ebdcb959	\N	auth-username-password-form	master	754ef344-e3f3-4449-a562-0916e079d984	0	10	f	\N	\N
c5ff60d2-c88e-4ebe-9179-b061a9ea177f	\N	\N	master	754ef344-e3f3-4449-a562-0916e079d984	1	20	t	0e07644c-a529-4835-b8d4-b9fbb5843f90	\N
bde386fa-4c71-46e1-b481-5066c44bbcf6	\N	conditional-user-configured	master	0e07644c-a529-4835-b8d4-b9fbb5843f90	0	10	f	\N	\N
40258bdf-cb00-4185-bf27-03865880c697	\N	auth-otp-form	master	0e07644c-a529-4835-b8d4-b9fbb5843f90	0	20	f	\N	\N
4cd5a217-bec3-4003-bbcc-d531c6aa25a0	\N	direct-grant-validate-username	master	bbaa95ea-6115-4b1c-88ea-2e7f883a9652	0	10	f	\N	\N
07dc5c42-86b9-48a5-9dfa-c97a12c07175	\N	direct-grant-validate-password	master	bbaa95ea-6115-4b1c-88ea-2e7f883a9652	0	20	f	\N	\N
b99ac659-c017-4f77-a9ed-bda34c2e5990	\N	\N	master	bbaa95ea-6115-4b1c-88ea-2e7f883a9652	1	30	t	1499b8ee-3771-4bd2-8b02-4fdcbfa2647f	\N
3347cf4f-fde7-42c9-86c4-7e764aa4440f	\N	conditional-user-configured	master	1499b8ee-3771-4bd2-8b02-4fdcbfa2647f	0	10	f	\N	\N
9c798788-50ea-45aa-8a29-0011d5827fb7	\N	direct-grant-validate-otp	master	1499b8ee-3771-4bd2-8b02-4fdcbfa2647f	0	20	f	\N	\N
d585f46b-f942-411c-837d-1d50dcffb6a6	\N	registration-page-form	master	71136b74-b058-46b3-9687-d4c835ca0ea2	0	10	t	dd53fd46-d8b6-479c-af4e-a628e9fdbe8a	\N
fbd48be4-bf7c-45f2-9c86-fb0e26278385	\N	registration-user-creation	master	dd53fd46-d8b6-479c-af4e-a628e9fdbe8a	0	20	f	\N	\N
420756c2-bbfe-4f4b-8d39-ada0bcd5a7a4	\N	registration-profile-action	master	dd53fd46-d8b6-479c-af4e-a628e9fdbe8a	0	40	f	\N	\N
ac641c12-722b-47c1-b9f0-f36e8b851ad7	\N	registration-password-action	master	dd53fd46-d8b6-479c-af4e-a628e9fdbe8a	0	50	f	\N	\N
8b7fe4c0-70fc-4900-b5fe-92d2424ce448	\N	registration-recaptcha-action	master	dd53fd46-d8b6-479c-af4e-a628e9fdbe8a	3	60	f	\N	\N
f0672eaf-9ffc-4347-9646-05af875c6c18	\N	reset-credentials-choose-user	master	b27e2186-2702-443e-b0d9-e6c3aecfbfe8	0	10	f	\N	\N
028441a5-cb8e-472d-a267-91d48f39cf92	\N	reset-credential-email	master	b27e2186-2702-443e-b0d9-e6c3aecfbfe8	0	20	f	\N	\N
53080258-029b-4241-9b7a-43833c245352	\N	reset-password	master	b27e2186-2702-443e-b0d9-e6c3aecfbfe8	0	30	f	\N	\N
44ae3110-f8e6-414f-a8dc-ff2cacdf7076	\N	\N	master	b27e2186-2702-443e-b0d9-e6c3aecfbfe8	1	40	t	96746b89-509f-4676-b652-db33441612ef	\N
7f1a06e0-428b-461f-97d5-b7441c08ef53	\N	conditional-user-configured	master	96746b89-509f-4676-b652-db33441612ef	0	10	f	\N	\N
5dcbd636-a713-4022-bf31-bcea3eb63b72	\N	reset-otp	master	96746b89-509f-4676-b652-db33441612ef	0	20	f	\N	\N
37b28f08-c9b7-4977-9bb3-d0fecb7115a4	\N	client-secret	master	c277a1d3-177d-4dcc-999d-4b70b0cfd640	2	10	f	\N	\N
918bcd7f-72bd-4e7b-84d7-fdc1e5e3185b	\N	client-jwt	master	c277a1d3-177d-4dcc-999d-4b70b0cfd640	2	20	f	\N	\N
9643bb15-b804-4b51-96eb-efdf516c345b	\N	client-secret-jwt	master	c277a1d3-177d-4dcc-999d-4b70b0cfd640	2	30	f	\N	\N
cfd2c583-edba-46a1-b1b7-c4b2bd888dce	\N	client-x509	master	c277a1d3-177d-4dcc-999d-4b70b0cfd640	2	40	f	\N	\N
b92a7ee9-c287-4afd-a635-8f6c003d3110	\N	idp-review-profile	master	4edaddbb-bc96-461c-8e70-0d25723177dd	0	10	f	\N	dc0eac62-96ff-407b-8353-bfbbf896a3e3
539967ac-fc85-4d59-bfff-382eeec1456d	\N	\N	master	4edaddbb-bc96-461c-8e70-0d25723177dd	0	20	t	fd889099-3862-42f0-b045-c375436736f4	\N
831acff1-80d1-4a8f-a3fa-28c288d0fb8a	\N	idp-create-user-if-unique	master	fd889099-3862-42f0-b045-c375436736f4	2	10	f	\N	714edb8b-4dce-4f3e-a90d-4037dc4f3f1c
361749dd-6c3c-4c96-9732-9e75f17bfa5e	\N	\N	master	fd889099-3862-42f0-b045-c375436736f4	2	20	t	f1ea624e-ab32-43ed-b3d4-a575d44cfbe5	\N
da1efc4f-571f-43f3-a1f3-c887e8fbbc36	\N	idp-confirm-link	master	f1ea624e-ab32-43ed-b3d4-a575d44cfbe5	0	10	f	\N	\N
527e65f1-ceee-4596-964e-568d09b2bda9	\N	\N	master	f1ea624e-ab32-43ed-b3d4-a575d44cfbe5	0	20	t	92718b6c-cc16-47e8-9710-cb532e8f4e98	\N
ad15c524-6396-4902-a8ce-bdc63bb4acec	\N	idp-email-verification	master	92718b6c-cc16-47e8-9710-cb532e8f4e98	2	10	f	\N	\N
bc49b005-7124-4a64-b829-e0d679d056ec	\N	\N	master	92718b6c-cc16-47e8-9710-cb532e8f4e98	2	20	t	8b32824f-1f51-4478-817c-c940d728808b	\N
173a2a2b-127f-4bd6-9bbe-be603efa9660	\N	idp-username-password-form	master	8b32824f-1f51-4478-817c-c940d728808b	0	10	f	\N	\N
379181d9-9076-4b65-8e93-c6edf9428c75	\N	\N	master	8b32824f-1f51-4478-817c-c940d728808b	1	20	t	b888bfd8-c170-42c1-94ab-a8da2cda6205	\N
42dd17a4-5105-4521-a4a6-98a75d300a9b	\N	conditional-user-configured	master	b888bfd8-c170-42c1-94ab-a8da2cda6205	0	10	f	\N	\N
5c1080c4-ed9b-483c-b12b-95ae368a3ae0	\N	auth-otp-form	master	b888bfd8-c170-42c1-94ab-a8da2cda6205	0	20	f	\N	\N
512dd8aa-0c0c-4245-ad83-38a937d6753c	\N	http-basic-authenticator	master	384c18fb-8ec2-4570-a79a-d9c9f6123e8c	0	10	f	\N	\N
2ad49548-d7e4-458d-9afe-806cd651a379	\N	docker-http-basic-authenticator	master	581ca990-30e8-4601-ae74-9e01f21ab5d0	0	10	f	\N	\N
21af6235-d183-4646-8f3a-e1bbb4ae1183	\N	no-cookie-redirect	master	06e9b1d8-a906-43f7-abf9-c682d7b7c2e3	0	10	f	\N	\N
2fbd25fb-abda-48ff-b7ee-70cadd72cbe0	\N	\N	master	06e9b1d8-a906-43f7-abf9-c682d7b7c2e3	0	20	t	6655bfb4-10d3-4afd-bb28-c3e8ad5e031d	\N
c3133aa0-ee67-4854-81d1-ec761c3a1074	\N	basic-auth	master	6655bfb4-10d3-4afd-bb28-c3e8ad5e031d	0	10	f	\N	\N
6009114f-f76f-457c-9ccd-7c241fa93156	\N	basic-auth-otp	master	6655bfb4-10d3-4afd-bb28-c3e8ad5e031d	3	20	f	\N	\N
941ffa3b-c13c-426f-a4fa-8f7d2dc73c53	\N	auth-spnego	master	6655bfb4-10d3-4afd-bb28-c3e8ad5e031d	3	30	f	\N	\N
5827e787-c052-411e-9893-f77d2f7940a8	\N	auth-cookie	test	f2a839f8-17ed-4219-8c9a-9e385937c090	2	10	f	\N	\N
e193bcdd-f7fc-466e-a15f-1f8bbf56e3c8	\N	auth-spnego	test	f2a839f8-17ed-4219-8c9a-9e385937c090	3	20	f	\N	\N
366e01a2-7714-428f-8c6c-77df5feb7d6e	\N	identity-provider-redirector	test	f2a839f8-17ed-4219-8c9a-9e385937c090	2	25	f	\N	\N
799028cc-6225-447a-a89d-32fc38ed2aed	\N	\N	test	f2a839f8-17ed-4219-8c9a-9e385937c090	2	30	t	9036d5b0-335f-442d-9e84-dc456ad45f49	\N
53d4dd23-30b0-4b9f-97ce-1fedc6bd1998	\N	auth-username-password-form	test	9036d5b0-335f-442d-9e84-dc456ad45f49	0	10	f	\N	\N
369c19db-2082-4a48-a85c-e47662f1f7b3	\N	\N	test	9036d5b0-335f-442d-9e84-dc456ad45f49	1	20	t	0bacbe14-8e00-491e-8197-0513bae3ed67	\N
d02860b7-8add-4555-bf59-0b151ad9bc9e	\N	conditional-user-configured	test	0bacbe14-8e00-491e-8197-0513bae3ed67	0	10	f	\N	\N
3b491084-f571-445a-9ae0-cbff7cc49d00	\N	auth-otp-form	test	0bacbe14-8e00-491e-8197-0513bae3ed67	0	20	f	\N	\N
b0449851-1c64-42c2-b058-8ebd99db4a82	\N	direct-grant-validate-username	test	54500e67-cee1-43cd-9777-b1728d60ec13	0	10	f	\N	\N
9440a354-4222-48dd-b056-8d5fd13c6f2a	\N	direct-grant-validate-password	test	54500e67-cee1-43cd-9777-b1728d60ec13	0	20	f	\N	\N
27884b12-aa51-44fc-9915-8c86b6b24085	\N	\N	test	54500e67-cee1-43cd-9777-b1728d60ec13	1	30	t	e55d688a-af5e-4ad1-bdfa-742ad1a249b1	\N
110e7b3f-ceb7-4ffc-857d-6f714306e769	\N	conditional-user-configured	test	e55d688a-af5e-4ad1-bdfa-742ad1a249b1	0	10	f	\N	\N
919a6c4e-2f78-4ed0-97ed-15ea69300ecd	\N	direct-grant-validate-otp	test	e55d688a-af5e-4ad1-bdfa-742ad1a249b1	0	20	f	\N	\N
71dc621d-253e-4ecb-b0ac-82a943914699	\N	registration-page-form	test	73e1871d-1ffe-42a0-b58c-487743391f8b	0	10	t	b0c7dab9-c782-469f-9bd5-871db3f09428	\N
269f9e23-a41a-456f-930a-0c22adc3f5b2	\N	registration-user-creation	test	b0c7dab9-c782-469f-9bd5-871db3f09428	0	20	f	\N	\N
1aecad92-56fd-4d51-815b-dad61b9e24a3	\N	registration-profile-action	test	b0c7dab9-c782-469f-9bd5-871db3f09428	0	40	f	\N	\N
eb23a108-b6a5-439c-a156-874aa5a0f957	\N	registration-password-action	test	b0c7dab9-c782-469f-9bd5-871db3f09428	0	50	f	\N	\N
d2022fd1-0fa8-4894-86fc-641efa2749cc	\N	registration-recaptcha-action	test	b0c7dab9-c782-469f-9bd5-871db3f09428	3	60	f	\N	\N
3ef4952f-75ac-46d0-a5f1-bfbb21d6859e	\N	reset-credentials-choose-user	test	f689c3f9-5c53-47b5-86ff-51e1638e5c4f	0	10	f	\N	\N
2c17fc8c-e40d-43cd-b010-9120161e729a	\N	reset-credential-email	test	f689c3f9-5c53-47b5-86ff-51e1638e5c4f	0	20	f	\N	\N
fa7da549-bf00-4fec-991a-1a525b8e6f90	\N	reset-password	test	f689c3f9-5c53-47b5-86ff-51e1638e5c4f	0	30	f	\N	\N
4bd1ca0e-a148-44bf-8df8-0766e0d030da	\N	\N	test	f689c3f9-5c53-47b5-86ff-51e1638e5c4f	1	40	t	c53f2906-7acc-4f3d-865e-4b20e8e2ba7b	\N
1eb18b1e-e98f-4dcc-b0de-0ebb3081bf8b	\N	conditional-user-configured	test	c53f2906-7acc-4f3d-865e-4b20e8e2ba7b	0	10	f	\N	\N
7d6576dd-7a84-422d-af6d-749dc1e7fc5c	\N	reset-otp	test	c53f2906-7acc-4f3d-865e-4b20e8e2ba7b	0	20	f	\N	\N
74c7ae18-45bf-40d3-bbbf-22ae236356be	\N	client-secret	test	6f625bbe-585e-4f87-aaaa-85dd04d4bca6	2	10	f	\N	\N
6c6d88d8-08de-4ac9-9e64-f125c20feae6	\N	client-jwt	test	6f625bbe-585e-4f87-aaaa-85dd04d4bca6	2	20	f	\N	\N
f43609ec-63eb-4598-aae1-7c55a50744a0	\N	client-secret-jwt	test	6f625bbe-585e-4f87-aaaa-85dd04d4bca6	2	30	f	\N	\N
84cea038-d06f-4ad9-b71f-b6bb2636936e	\N	client-x509	test	6f625bbe-585e-4f87-aaaa-85dd04d4bca6	2	40	f	\N	\N
1c2a1bfd-433a-4db9-8d28-e0f9efab204c	\N	idp-review-profile	test	7684f41c-764b-494d-940f-e65a03d4172a	0	10	f	\N	b1290cae-e4ed-4e1d-a543-515c4006cd87
9c03cc35-3e5f-4876-a328-c397a8d14e3a	\N	\N	test	7684f41c-764b-494d-940f-e65a03d4172a	0	20	t	e18da130-b831-4d5f-9062-ce14bd4bb614	\N
f1619308-3b0c-49b7-97fe-f1d6e17139e9	\N	idp-create-user-if-unique	test	e18da130-b831-4d5f-9062-ce14bd4bb614	2	10	f	\N	404e6b1b-0120-4073-8cb5-439d67c06e06
485dff84-1bf9-42ce-a374-20b29dafaff9	\N	\N	test	e18da130-b831-4d5f-9062-ce14bd4bb614	2	20	t	aa65aaa3-967b-42b1-9f52-8aed9468b7bd	\N
c6b1104e-5b51-412e-8706-e5f0421eb825	\N	idp-confirm-link	test	aa65aaa3-967b-42b1-9f52-8aed9468b7bd	0	10	f	\N	\N
afb43e8a-3909-44b7-8b7f-1131041691d7	\N	\N	test	aa65aaa3-967b-42b1-9f52-8aed9468b7bd	0	20	t	c43be3f2-49a2-4aa5-afdb-d1fa65a003bf	\N
7d928a29-ce69-4f82-b80f-a9c026a90578	\N	idp-email-verification	test	c43be3f2-49a2-4aa5-afdb-d1fa65a003bf	2	10	f	\N	\N
b86b4106-d53c-4830-a265-4577ce0c0f3d	\N	\N	test	c43be3f2-49a2-4aa5-afdb-d1fa65a003bf	2	20	t	10e4ff79-a8fa-479e-89aa-573f7acafb31	\N
89057dea-6b94-4330-9738-79db094b5ef7	\N	idp-username-password-form	test	10e4ff79-a8fa-479e-89aa-573f7acafb31	0	10	f	\N	\N
c889302f-7ad9-4330-bbde-89f9c948f11f	\N	\N	test	10e4ff79-a8fa-479e-89aa-573f7acafb31	1	20	t	bb44611d-70d9-41bf-9f36-6ce7c3946319	\N
0b485d8b-f07e-428a-922e-35ee5eb83129	\N	conditional-user-configured	test	bb44611d-70d9-41bf-9f36-6ce7c3946319	0	10	f	\N	\N
d169c749-0bab-4bfa-bcb6-fc1c34987dce	\N	auth-otp-form	test	bb44611d-70d9-41bf-9f36-6ce7c3946319	0	20	f	\N	\N
5957a842-c17f-47b0-8403-fba08a1b2e94	\N	http-basic-authenticator	test	8952c81c-2b2a-4390-9b06-46fec7e87701	0	10	f	\N	\N
d351f05d-b7ef-4261-b08b-4cf3da5c6f25	\N	docker-http-basic-authenticator	test	32514373-4fc7-4061-9801-1198de02e16e	0	10	f	\N	\N
467bd403-ab96-4e0f-b4c8-c33c84ba2ed8	\N	no-cookie-redirect	test	212da249-cd73-4999-9a01-f20ed34082ff	0	10	f	\N	\N
0092996f-52d5-48e6-a203-f4dbc8a603b6	\N	\N	test	212da249-cd73-4999-9a01-f20ed34082ff	0	20	t	5d1b3ba5-2882-4131-aa68-fbe48fc6ad11	\N
4655630f-3c9e-4345-825b-802fce27d1b0	\N	basic-auth	test	5d1b3ba5-2882-4131-aa68-fbe48fc6ad11	0	10	f	\N	\N
55ec2e52-dc6d-4ff4-8891-858ff77ad5b8	\N	basic-auth-otp	test	5d1b3ba5-2882-4131-aa68-fbe48fc6ad11	3	20	f	\N	\N
e61e8793-84df-4a79-b452-0eaa5e83f820	\N	auth-spnego	test	5d1b3ba5-2882-4131-aa68-fbe48fc6ad11	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
aed1f280-a5a5-4922-af01-2d7041010485	browser	browser based authentication	master	basic-flow	t	t
754ef344-e3f3-4449-a562-0916e079d984	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
0e07644c-a529-4835-b8d4-b9fbb5843f90	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
bbaa95ea-6115-4b1c-88ea-2e7f883a9652	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
1499b8ee-3771-4bd2-8b02-4fdcbfa2647f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
71136b74-b058-46b3-9687-d4c835ca0ea2	registration	registration flow	master	basic-flow	t	t
dd53fd46-d8b6-479c-af4e-a628e9fdbe8a	registration form	registration form	master	form-flow	f	t
b27e2186-2702-443e-b0d9-e6c3aecfbfe8	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
96746b89-509f-4676-b652-db33441612ef	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
c277a1d3-177d-4dcc-999d-4b70b0cfd640	clients	Base authentication for clients	master	client-flow	t	t
4edaddbb-bc96-461c-8e70-0d25723177dd	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
fd889099-3862-42f0-b045-c375436736f4	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
f1ea624e-ab32-43ed-b3d4-a575d44cfbe5	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
92718b6c-cc16-47e8-9710-cb532e8f4e98	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
8b32824f-1f51-4478-817c-c940d728808b	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
b888bfd8-c170-42c1-94ab-a8da2cda6205	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
384c18fb-8ec2-4570-a79a-d9c9f6123e8c	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
581ca990-30e8-4601-ae74-9e01f21ab5d0	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
06e9b1d8-a906-43f7-abf9-c682d7b7c2e3	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
6655bfb4-10d3-4afd-bb28-c3e8ad5e031d	Authentication Options	Authentication options.	master	basic-flow	f	t
f2a839f8-17ed-4219-8c9a-9e385937c090	browser	browser based authentication	test	basic-flow	t	t
9036d5b0-335f-442d-9e84-dc456ad45f49	forms	Username, password, otp and other auth forms.	test	basic-flow	f	t
0bacbe14-8e00-491e-8197-0513bae3ed67	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	test	basic-flow	f	t
54500e67-cee1-43cd-9777-b1728d60ec13	direct grant	OpenID Connect Resource Owner Grant	test	basic-flow	t	t
e55d688a-af5e-4ad1-bdfa-742ad1a249b1	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	test	basic-flow	f	t
73e1871d-1ffe-42a0-b58c-487743391f8b	registration	registration flow	test	basic-flow	t	t
b0c7dab9-c782-469f-9bd5-871db3f09428	registration form	registration form	test	form-flow	f	t
f689c3f9-5c53-47b5-86ff-51e1638e5c4f	reset credentials	Reset credentials for a user if they forgot their password or something	test	basic-flow	t	t
c53f2906-7acc-4f3d-865e-4b20e8e2ba7b	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	test	basic-flow	f	t
6f625bbe-585e-4f87-aaaa-85dd04d4bca6	clients	Base authentication for clients	test	client-flow	t	t
7684f41c-764b-494d-940f-e65a03d4172a	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	test	basic-flow	t	t
e18da130-b831-4d5f-9062-ce14bd4bb614	User creation or linking	Flow for the existing/non-existing user alternatives	test	basic-flow	f	t
aa65aaa3-967b-42b1-9f52-8aed9468b7bd	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	test	basic-flow	f	t
c43be3f2-49a2-4aa5-afdb-d1fa65a003bf	Account verification options	Method with which to verity the existing account	test	basic-flow	f	t
10e4ff79-a8fa-479e-89aa-573f7acafb31	Verify Existing Account by Re-authentication	Reauthentication of existing account	test	basic-flow	f	t
bb44611d-70d9-41bf-9f36-6ce7c3946319	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	test	basic-flow	f	t
8952c81c-2b2a-4390-9b06-46fec7e87701	saml ecp	SAML ECP Profile Authentication Flow	test	basic-flow	t	t
32514373-4fc7-4061-9801-1198de02e16e	docker auth	Used by Docker clients to authenticate against the IDP	test	basic-flow	t	t
212da249-cd73-4999-9a01-f20ed34082ff	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	test	basic-flow	t	t
5d1b3ba5-2882-4131-aa68-fbe48fc6ad11	Authentication Options	Authentication options.	test	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
dc0eac62-96ff-407b-8353-bfbbf896a3e3	review profile config	master
714edb8b-4dce-4f3e-a90d-4037dc4f3f1c	create unique user config	master
b1290cae-e4ed-4e1d-a543-515c4006cd87	review profile config	test
404e6b1b-0120-4073-8cb5-439d67c06e06	create unique user config	test
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
dc0eac62-96ff-407b-8353-bfbbf896a3e3	missing	update.profile.on.first.login
714edb8b-4dce-4f3e-a90d-4037dc4f3f1c	false	require.password.update.after.registration
b1290cae-e4ed-4e1d-a543-515c4006cd87	missing	update.profile.on.first.login
404e6b1b-0120-4073-8cb5-439d67c06e06	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled) FROM stdin;
abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	t	master-realm	0	f	47e3e106-24d3-4300-91c3-0dd4fae23732	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f
ea3b6386-3a19-4970-8b4e-be48fe310294	t	f	account	0	f	7cf14e11-e0e3-4a0c-8d05-8ff64335eadd	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f
f50e49e4-eed0-4377-864c-6e5e238a0701	t	f	broker	0	f	ef576464-0402-4d51-8d22-d22c5871524d	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
211b769c-3db2-420a-93a3-aee2d24990b1	t	f	security-admin-console	0	t	94969810-2b1b-4b5d-bcf0-68578aa70d30	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	t	f	admin-cli	0	t	d7c32bab-319e-4233-9823-e7b975617964	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
8da5b847-e08a-4416-b7bb-19da50324f32	t	t	test-realm	0	f	1d8d1f9c-48b9-4de6-a1a4-716066506d0f	\N	t	\N	f	master	\N	0	f	f	test Realm	f	client-secret	\N	\N	\N	t	f	f
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	f	realm-management	0	f	7c02837c-159c-4540-9bfb-c8333350a069	\N	t	\N	f	test	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f
d92ffcff-af21-4144-b731-a89bd59cdf5e	t	f	account	0	f	b84a75fd-0e60-49ea-866b-7c3ed67c01c2	/realms/test/account/	f	\N	f	test	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f
485585ef-7faf-4d8b-8e57-b663ae3b4265	t	f	broker	0	f	18bdf874-3d81-4454-87f7-3940156ac97d	\N	f	\N	f	test	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f
810c10be-2cca-472b-9785-23a7e2668a9c	t	f	security-admin-console	0	t	e164482e-639b-43a8-b5b4-f7e6e1b65459	/admin/test/console/	f	\N	f	test	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f
8b1f4af8-a35d-49de-a2ee-c6b74983632e	t	f	admin-cli	0	t	da5730fa-5175-4d8b-a424-2e037d2d02e9	\N	f	\N	f	test	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t
e62df68a-4189-4aaa-b5cd-09909251c2a3	t	t	myapp	0	t	c40ef13e-0740-4844-b801-2c4c03ae3f25	\N	f	\N	f	test	openid-connect	-1	f	f	\N	f	client-secret	http://localhost:8000	\N	\N	t	f	t
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	t	t	kong	0	f	4cd2e98f-df15-4972-84c8-1be974e9aba6	\N	f	http://localhost:8000/users/login	f	test	openid-connect	-1	f	f	\N	t	client-secret	http://localhost:8000	\N	\N	t	f	t
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.server.signature
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.server.signature.keyinfo.ext
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.assertion.signature
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.client.signature
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.encrypt
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.authnstatement
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.onetimeuse.condition
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml_force_name_id_format
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.multivalued.roles
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	saml.force.post.binding
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	exclude.session.state.from.auth.response
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	tls.client.certificate.bound.access.tokens
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	false	display.on.consent.screen
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.server.signature
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.server.signature.keyinfo.ext
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.assertion.signature
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.client.signature
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.encrypt
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.authnstatement
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.onetimeuse.condition
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml_force_name_id_format
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.multivalued.roles
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	saml.force.post.binding
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	exclude.session.state.from.auth.response
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	tls.client.certificate.bound.access.tokens
e62df68a-4189-4aaa-b5cd-09909251c2a3	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
ea3b6386-3a19-4970-8b4e-be48fe310294	917ce590-59c7-4a05-b488-7735cae4452d
ea3b6386-3a19-4970-8b4e-be48fe310294	b3337f6f-5016-49cd-912b-517f30e5bc07
d92ffcff-af21-4144-b731-a89bd59cdf5e	c1fa9ff0-acb6-4c1e-b4a5-2b6ed40138f5
d92ffcff-af21-4144-b731-a89bd59cdf5e	82fbe66e-a7b7-44ec-ae66-72746eb06f04
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
a71ddb95-2806-4c0e-a356-1661b0799afd	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
d8cfba15-e4ac-4e31-983d-955b03ac2dfa	role_list	master	SAML role list	saml
227bad54-a26e-4539-8d18-b3bb4c5435cb	profile	master	OpenID Connect built-in scope: profile	openid-connect
5e31b682-00c0-495b-ac0a-b97e8826798e	email	master	OpenID Connect built-in scope: email	openid-connect
32a3efe1-adc1-4209-999b-9ee5c33be537	address	master	OpenID Connect built-in scope: address	openid-connect
caf270d3-02ad-4d34-9fbb-746bb7bc4668	phone	master	OpenID Connect built-in scope: phone	openid-connect
f79fb725-9337-4d02-834e-e971e4593836	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
d2dc6f42-56af-4d59-a92a-ce10eb52b34d	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
68076ec8-04cb-40b7-b571-0b668632a2d0	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
e942a88e-2f6f-41bc-a73f-dd7bb2e65757	offline_access	test	OpenID Connect built-in scope: offline_access	openid-connect
81a2c111-5a04-42b7-8792-38ee44689e07	role_list	test	SAML role list	saml
e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	profile	test	OpenID Connect built-in scope: profile	openid-connect
423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	email	test	OpenID Connect built-in scope: email	openid-connect
a6b9823c-361f-42b9-8ee0-44c113f4e30f	address	test	OpenID Connect built-in scope: address	openid-connect
8893628d-2430-4c5f-af96-3653480a307d	phone	test	OpenID Connect built-in scope: phone	openid-connect
85309e05-6c1b-44ac-90e3-8607f836a07b	roles	test	OpenID Connect scope for add user roles to the access token	openid-connect
088c8b28-fb69-4cbe-af4c-f5caee3c6df2	web-origins	test	OpenID Connect scope for add allowed web origins to the access token	openid-connect
de45c7c1-4c48-49d0-a94f-ddfd560eaeed	microprofile-jwt	test	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
a71ddb95-2806-4c0e-a356-1661b0799afd	true	display.on.consent.screen
a71ddb95-2806-4c0e-a356-1661b0799afd	${offlineAccessScopeConsentText}	consent.screen.text
d8cfba15-e4ac-4e31-983d-955b03ac2dfa	true	display.on.consent.screen
d8cfba15-e4ac-4e31-983d-955b03ac2dfa	${samlRoleListScopeConsentText}	consent.screen.text
227bad54-a26e-4539-8d18-b3bb4c5435cb	true	display.on.consent.screen
227bad54-a26e-4539-8d18-b3bb4c5435cb	${profileScopeConsentText}	consent.screen.text
227bad54-a26e-4539-8d18-b3bb4c5435cb	true	include.in.token.scope
5e31b682-00c0-495b-ac0a-b97e8826798e	true	display.on.consent.screen
5e31b682-00c0-495b-ac0a-b97e8826798e	${emailScopeConsentText}	consent.screen.text
5e31b682-00c0-495b-ac0a-b97e8826798e	true	include.in.token.scope
32a3efe1-adc1-4209-999b-9ee5c33be537	true	display.on.consent.screen
32a3efe1-adc1-4209-999b-9ee5c33be537	${addressScopeConsentText}	consent.screen.text
32a3efe1-adc1-4209-999b-9ee5c33be537	true	include.in.token.scope
caf270d3-02ad-4d34-9fbb-746bb7bc4668	true	display.on.consent.screen
caf270d3-02ad-4d34-9fbb-746bb7bc4668	${phoneScopeConsentText}	consent.screen.text
caf270d3-02ad-4d34-9fbb-746bb7bc4668	true	include.in.token.scope
f79fb725-9337-4d02-834e-e971e4593836	true	display.on.consent.screen
f79fb725-9337-4d02-834e-e971e4593836	${rolesScopeConsentText}	consent.screen.text
f79fb725-9337-4d02-834e-e971e4593836	false	include.in.token.scope
d2dc6f42-56af-4d59-a92a-ce10eb52b34d	false	display.on.consent.screen
d2dc6f42-56af-4d59-a92a-ce10eb52b34d		consent.screen.text
d2dc6f42-56af-4d59-a92a-ce10eb52b34d	false	include.in.token.scope
68076ec8-04cb-40b7-b571-0b668632a2d0	false	display.on.consent.screen
68076ec8-04cb-40b7-b571-0b668632a2d0	true	include.in.token.scope
e942a88e-2f6f-41bc-a73f-dd7bb2e65757	true	display.on.consent.screen
e942a88e-2f6f-41bc-a73f-dd7bb2e65757	${offlineAccessScopeConsentText}	consent.screen.text
81a2c111-5a04-42b7-8792-38ee44689e07	true	display.on.consent.screen
81a2c111-5a04-42b7-8792-38ee44689e07	${samlRoleListScopeConsentText}	consent.screen.text
e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	true	display.on.consent.screen
e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	${profileScopeConsentText}	consent.screen.text
e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	true	include.in.token.scope
423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	true	display.on.consent.screen
423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	${emailScopeConsentText}	consent.screen.text
423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	true	include.in.token.scope
a6b9823c-361f-42b9-8ee0-44c113f4e30f	true	display.on.consent.screen
a6b9823c-361f-42b9-8ee0-44c113f4e30f	${addressScopeConsentText}	consent.screen.text
a6b9823c-361f-42b9-8ee0-44c113f4e30f	true	include.in.token.scope
8893628d-2430-4c5f-af96-3653480a307d	true	display.on.consent.screen
8893628d-2430-4c5f-af96-3653480a307d	${phoneScopeConsentText}	consent.screen.text
8893628d-2430-4c5f-af96-3653480a307d	true	include.in.token.scope
85309e05-6c1b-44ac-90e3-8607f836a07b	true	display.on.consent.screen
85309e05-6c1b-44ac-90e3-8607f836a07b	${rolesScopeConsentText}	consent.screen.text
85309e05-6c1b-44ac-90e3-8607f836a07b	false	include.in.token.scope
088c8b28-fb69-4cbe-af4c-f5caee3c6df2	false	display.on.consent.screen
088c8b28-fb69-4cbe-af4c-f5caee3c6df2		consent.screen.text
088c8b28-fb69-4cbe-af4c-f5caee3c6df2	false	include.in.token.scope
de45c7c1-4c48-49d0-a94f-ddfd560eaeed	false	display.on.consent.screen
de45c7c1-4c48-49d0-a94f-ddfd560eaeed	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
ea3b6386-3a19-4970-8b4e-be48fe310294	d8cfba15-e4ac-4e31-983d-955b03ac2dfa	t
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	d8cfba15-e4ac-4e31-983d-955b03ac2dfa	t
f50e49e4-eed0-4377-864c-6e5e238a0701	d8cfba15-e4ac-4e31-983d-955b03ac2dfa	t
abc7f818-4fd6-4b54-a3c6-48b18c789c00	d8cfba15-e4ac-4e31-983d-955b03ac2dfa	t
211b769c-3db2-420a-93a3-aee2d24990b1	d8cfba15-e4ac-4e31-983d-955b03ac2dfa	t
ea3b6386-3a19-4970-8b4e-be48fe310294	227bad54-a26e-4539-8d18-b3bb4c5435cb	t
ea3b6386-3a19-4970-8b4e-be48fe310294	5e31b682-00c0-495b-ac0a-b97e8826798e	t
ea3b6386-3a19-4970-8b4e-be48fe310294	f79fb725-9337-4d02-834e-e971e4593836	t
ea3b6386-3a19-4970-8b4e-be48fe310294	d2dc6f42-56af-4d59-a92a-ce10eb52b34d	t
ea3b6386-3a19-4970-8b4e-be48fe310294	a71ddb95-2806-4c0e-a356-1661b0799afd	f
ea3b6386-3a19-4970-8b4e-be48fe310294	32a3efe1-adc1-4209-999b-9ee5c33be537	f
ea3b6386-3a19-4970-8b4e-be48fe310294	caf270d3-02ad-4d34-9fbb-746bb7bc4668	f
ea3b6386-3a19-4970-8b4e-be48fe310294	68076ec8-04cb-40b7-b571-0b668632a2d0	f
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	227bad54-a26e-4539-8d18-b3bb4c5435cb	t
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	5e31b682-00c0-495b-ac0a-b97e8826798e	t
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	f79fb725-9337-4d02-834e-e971e4593836	t
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	d2dc6f42-56af-4d59-a92a-ce10eb52b34d	t
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	a71ddb95-2806-4c0e-a356-1661b0799afd	f
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	32a3efe1-adc1-4209-999b-9ee5c33be537	f
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	caf270d3-02ad-4d34-9fbb-746bb7bc4668	f
458c2d33-cfe3-4ff6-9466-5e5bd29dcb7e	68076ec8-04cb-40b7-b571-0b668632a2d0	f
f50e49e4-eed0-4377-864c-6e5e238a0701	227bad54-a26e-4539-8d18-b3bb4c5435cb	t
f50e49e4-eed0-4377-864c-6e5e238a0701	5e31b682-00c0-495b-ac0a-b97e8826798e	t
f50e49e4-eed0-4377-864c-6e5e238a0701	f79fb725-9337-4d02-834e-e971e4593836	t
f50e49e4-eed0-4377-864c-6e5e238a0701	d2dc6f42-56af-4d59-a92a-ce10eb52b34d	t
f50e49e4-eed0-4377-864c-6e5e238a0701	a71ddb95-2806-4c0e-a356-1661b0799afd	f
f50e49e4-eed0-4377-864c-6e5e238a0701	32a3efe1-adc1-4209-999b-9ee5c33be537	f
f50e49e4-eed0-4377-864c-6e5e238a0701	caf270d3-02ad-4d34-9fbb-746bb7bc4668	f
f50e49e4-eed0-4377-864c-6e5e238a0701	68076ec8-04cb-40b7-b571-0b668632a2d0	f
abc7f818-4fd6-4b54-a3c6-48b18c789c00	227bad54-a26e-4539-8d18-b3bb4c5435cb	t
abc7f818-4fd6-4b54-a3c6-48b18c789c00	5e31b682-00c0-495b-ac0a-b97e8826798e	t
abc7f818-4fd6-4b54-a3c6-48b18c789c00	f79fb725-9337-4d02-834e-e971e4593836	t
abc7f818-4fd6-4b54-a3c6-48b18c789c00	d2dc6f42-56af-4d59-a92a-ce10eb52b34d	t
abc7f818-4fd6-4b54-a3c6-48b18c789c00	a71ddb95-2806-4c0e-a356-1661b0799afd	f
abc7f818-4fd6-4b54-a3c6-48b18c789c00	32a3efe1-adc1-4209-999b-9ee5c33be537	f
abc7f818-4fd6-4b54-a3c6-48b18c789c00	caf270d3-02ad-4d34-9fbb-746bb7bc4668	f
abc7f818-4fd6-4b54-a3c6-48b18c789c00	68076ec8-04cb-40b7-b571-0b668632a2d0	f
211b769c-3db2-420a-93a3-aee2d24990b1	227bad54-a26e-4539-8d18-b3bb4c5435cb	t
211b769c-3db2-420a-93a3-aee2d24990b1	5e31b682-00c0-495b-ac0a-b97e8826798e	t
211b769c-3db2-420a-93a3-aee2d24990b1	f79fb725-9337-4d02-834e-e971e4593836	t
211b769c-3db2-420a-93a3-aee2d24990b1	d2dc6f42-56af-4d59-a92a-ce10eb52b34d	t
211b769c-3db2-420a-93a3-aee2d24990b1	a71ddb95-2806-4c0e-a356-1661b0799afd	f
211b769c-3db2-420a-93a3-aee2d24990b1	32a3efe1-adc1-4209-999b-9ee5c33be537	f
211b769c-3db2-420a-93a3-aee2d24990b1	caf270d3-02ad-4d34-9fbb-746bb7bc4668	f
211b769c-3db2-420a-93a3-aee2d24990b1	68076ec8-04cb-40b7-b571-0b668632a2d0	f
8da5b847-e08a-4416-b7bb-19da50324f32	d8cfba15-e4ac-4e31-983d-955b03ac2dfa	t
8da5b847-e08a-4416-b7bb-19da50324f32	227bad54-a26e-4539-8d18-b3bb4c5435cb	t
8da5b847-e08a-4416-b7bb-19da50324f32	5e31b682-00c0-495b-ac0a-b97e8826798e	t
8da5b847-e08a-4416-b7bb-19da50324f32	f79fb725-9337-4d02-834e-e971e4593836	t
8da5b847-e08a-4416-b7bb-19da50324f32	d2dc6f42-56af-4d59-a92a-ce10eb52b34d	t
8da5b847-e08a-4416-b7bb-19da50324f32	a71ddb95-2806-4c0e-a356-1661b0799afd	f
8da5b847-e08a-4416-b7bb-19da50324f32	32a3efe1-adc1-4209-999b-9ee5c33be537	f
8da5b847-e08a-4416-b7bb-19da50324f32	caf270d3-02ad-4d34-9fbb-746bb7bc4668	f
8da5b847-e08a-4416-b7bb-19da50324f32	68076ec8-04cb-40b7-b571-0b668632a2d0	f
d92ffcff-af21-4144-b731-a89bd59cdf5e	81a2c111-5a04-42b7-8792-38ee44689e07	t
8b1f4af8-a35d-49de-a2ee-c6b74983632e	81a2c111-5a04-42b7-8792-38ee44689e07	t
485585ef-7faf-4d8b-8e57-b663ae3b4265	81a2c111-5a04-42b7-8792-38ee44689e07	t
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	81a2c111-5a04-42b7-8792-38ee44689e07	t
810c10be-2cca-472b-9785-23a7e2668a9c	81a2c111-5a04-42b7-8792-38ee44689e07	t
d92ffcff-af21-4144-b731-a89bd59cdf5e	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
d92ffcff-af21-4144-b731-a89bd59cdf5e	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
d92ffcff-af21-4144-b731-a89bd59cdf5e	85309e05-6c1b-44ac-90e3-8607f836a07b	t
d92ffcff-af21-4144-b731-a89bd59cdf5e	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
d92ffcff-af21-4144-b731-a89bd59cdf5e	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
d92ffcff-af21-4144-b731-a89bd59cdf5e	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
d92ffcff-af21-4144-b731-a89bd59cdf5e	8893628d-2430-4c5f-af96-3653480a307d	f
d92ffcff-af21-4144-b731-a89bd59cdf5e	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
8b1f4af8-a35d-49de-a2ee-c6b74983632e	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
8b1f4af8-a35d-49de-a2ee-c6b74983632e	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
8b1f4af8-a35d-49de-a2ee-c6b74983632e	85309e05-6c1b-44ac-90e3-8607f836a07b	t
8b1f4af8-a35d-49de-a2ee-c6b74983632e	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
8b1f4af8-a35d-49de-a2ee-c6b74983632e	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
8b1f4af8-a35d-49de-a2ee-c6b74983632e	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
8b1f4af8-a35d-49de-a2ee-c6b74983632e	8893628d-2430-4c5f-af96-3653480a307d	f
8b1f4af8-a35d-49de-a2ee-c6b74983632e	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
485585ef-7faf-4d8b-8e57-b663ae3b4265	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
485585ef-7faf-4d8b-8e57-b663ae3b4265	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
485585ef-7faf-4d8b-8e57-b663ae3b4265	85309e05-6c1b-44ac-90e3-8607f836a07b	t
485585ef-7faf-4d8b-8e57-b663ae3b4265	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
485585ef-7faf-4d8b-8e57-b663ae3b4265	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
485585ef-7faf-4d8b-8e57-b663ae3b4265	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
485585ef-7faf-4d8b-8e57-b663ae3b4265	8893628d-2430-4c5f-af96-3653480a307d	f
485585ef-7faf-4d8b-8e57-b663ae3b4265	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	85309e05-6c1b-44ac-90e3-8607f836a07b	t
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	8893628d-2430-4c5f-af96-3653480a307d	f
b20abab0-f5e5-42ea-b79e-0dbdf11484ba	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
810c10be-2cca-472b-9785-23a7e2668a9c	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
810c10be-2cca-472b-9785-23a7e2668a9c	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
810c10be-2cca-472b-9785-23a7e2668a9c	85309e05-6c1b-44ac-90e3-8607f836a07b	t
810c10be-2cca-472b-9785-23a7e2668a9c	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
810c10be-2cca-472b-9785-23a7e2668a9c	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
810c10be-2cca-472b-9785-23a7e2668a9c	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
810c10be-2cca-472b-9785-23a7e2668a9c	8893628d-2430-4c5f-af96-3653480a307d	f
810c10be-2cca-472b-9785-23a7e2668a9c	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	81a2c111-5a04-42b7-8792-38ee44689e07	t
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	85309e05-6c1b-44ac-90e3-8607f836a07b	t
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	8893628d-2430-4c5f-af96-3653480a307d	f
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
e62df68a-4189-4aaa-b5cd-09909251c2a3	81a2c111-5a04-42b7-8792-38ee44689e07	t
e62df68a-4189-4aaa-b5cd-09909251c2a3	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
e62df68a-4189-4aaa-b5cd-09909251c2a3	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
e62df68a-4189-4aaa-b5cd-09909251c2a3	85309e05-6c1b-44ac-90e3-8607f836a07b	t
e62df68a-4189-4aaa-b5cd-09909251c2a3	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
e62df68a-4189-4aaa-b5cd-09909251c2a3	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
e62df68a-4189-4aaa-b5cd-09909251c2a3	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
e62df68a-4189-4aaa-b5cd-09909251c2a3	8893628d-2430-4c5f-af96-3653480a307d	f
e62df68a-4189-4aaa-b5cd-09909251c2a3	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
a71ddb95-2806-4c0e-a356-1661b0799afd	c93975fb-d01d-46de-ba8a-3cf949e09db1
e942a88e-2f6f-41bc-a73f-dd7bb2e65757	d5eb4e92-88e2-4bfc-b11a-e3a338d12953
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
8a30a192-6759-4e37-a582-883b4fbd1b85	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ff091115-f439-44f6-85ec-eb37bc4abc9b	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
113a0653-6e55-490b-af0b-101441e7574e	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
974c22a2-59ff-4c0c-aa03-0b04c2c3b233	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
b5d8a919-f959-4f18-9055-3b4ccf31db1a	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
0cd03bfe-6c2f-4f6f-afec-58d924ced722	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
0f067db7-4a6a-4691-a6e2-28f569664f0f	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
7b879ca6-09e5-4aee-8643-905ad6576db6	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
1a7472db-e2d8-4bf7-9540-d0d2d2be7bab	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
2d209934-dbe8-4278-856e-fb24c2fd379d	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
9c2ef544-efcd-4480-9224-75ee446905d7	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
846a68dd-361c-4f68-b2d0-0a47c9d5870a	rsa-generated	test	rsa-generated	org.keycloak.keys.KeyProvider	test	\N
d7c1eeaf-ca8a-46d3-a04f-1df4e5379d84	hmac-generated	test	hmac-generated	org.keycloak.keys.KeyProvider	test	\N
a6bf33e3-193e-45f1-a27f-bd36e8f7934a	aes-generated	test	aes-generated	org.keycloak.keys.KeyProvider	test	\N
cfaa532c-4507-4d04-b8ee-84541e01c0c6	Trusted Hosts	test	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
9856b675-34a7-4aaa-8804-b2c96341dacd	Consent Required	test	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
bcadd540-1bc6-4d1f-b5fd-522c695a1247	Full Scope Disabled	test	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
0977044a-cf50-4aa9-b926-c668b08cb6bb	Max Clients Limit	test	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
e79c38d4-06c9-4085-af4e-3b98093aa81e	Allowed Protocol Mapper Types	test	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
a585fa3e-04fc-4349-b52b-8a9a1ef83206	Allowed Client Scopes	test	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	anonymous
f6e251fc-41e9-4399-baed-7d6d6e1e049f	Allowed Protocol Mapper Types	test	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	authenticated
800b0e12-1cc1-4a4d-bedd-a5d91482182d	Allowed Client Scopes	test	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	test	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
89cca6c2-f2fd-4b09-b8dc-b9879841e6cc	7b879ca6-09e5-4aee-8643-905ad6576db6	allow-default-scopes	true
d7f26469-2770-4990-b501-c8bd8124833a	974c22a2-59ff-4c0c-aa03-0b04c2c3b233	max-clients	200
af68cc6e-03ae-403c-94fd-b4fbe534e7fe	8a30a192-6759-4e37-a582-883b4fbd1b85	host-sending-registration-request-must-match	true
f504e410-b21d-428e-befe-7651c1693e7c	8a30a192-6759-4e37-a582-883b4fbd1b85	client-uris-must-match	true
d2ef6db3-a2c3-4c5f-a8ff-b9d62c35b0de	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	oidc-address-mapper
64f42332-21fb-4b4a-ad81-d306a98a37e4	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	oidc-full-name-mapper
cc5f5cb6-e1a4-46b5-9d49-61127fcc5a00	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	saml-role-list-mapper
960c8c05-a89d-442a-aaf6-b279e4a5da43	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	saml-user-property-mapper
d1aeea66-bbb1-413f-b46d-bba3ea206baa	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fcccb20f-649c-4b29-864f-58e73a737b42	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	saml-user-attribute-mapper
9ea0ea33-f5d8-4fe1-b09c-569e531aed82	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ffd23f74-9bdf-4968-8bcb-1a2232a035bd	b5d8a919-f959-4f18-9055-3b4ccf31db1a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4f9c7c04-f0b2-42d8-8288-dc471bdf74cd	0cd03bfe-6c2f-4f6f-afec-58d924ced722	allow-default-scopes	true
34950b52-c9fe-4032-8d86-db30dfdcb394	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6c2910c2-4a50-4049-ae39-6d4b5d7802f5	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c9187b32-22c5-4d5e-91fa-f24a66f7e68f	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	saml-user-attribute-mapper
341b1dfb-1e99-4037-9d22-5b126e3f0614	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	oidc-address-mapper
ad120240-ebb6-4e7a-a343-78d8dca216d9	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	saml-role-list-mapper
d90bfe30-a7c5-4dc5-902a-92597ae3a3c7	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	saml-user-property-mapper
ec472741-f197-464f-847c-0c9e8ce4c5f9	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	oidc-full-name-mapper
d48c4d72-b9fe-4c98-a759-5408ff4278b1	0f067db7-4a6a-4691-a6e2-28f569664f0f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d4f75699-0367-4215-bf96-f9fe77615a39	1a7472db-e2d8-4bf7-9540-d0d2d2be7bab	priority	100
783942ef-fea6-4835-a222-70a96e59fc14	1a7472db-e2d8-4bf7-9540-d0d2d2be7bab	privateKey	MIIEpAIBAAKCAQEAmp0GQxPGsUoxRQB27ER4BaJ3WjRcdDwm9r0pvVhLhxH0z+6WkrYdFW07/E5YHRr1Ptk3JGFHuogrv9llW45fdIm57XWd4636b7vO+BcvBIViYVYjP+uy39mFyztx5D69dydp5h4LFhgzpNWKl62+fttaA/J0qxAfjw6VhOmQoDKB0u+25iKJK3jLshn/fZ3IbngSMw+erqBDt6BBcVJ7UGKanA2N3MEb3fNstCSps49iSuXv6NI84hYoe8HouZe+yXyTOxJbiKbaapr4x8Ok8k0moY9awQW5OjNZJj0TY0YhgjhkSZqp14khWLmQ1hZlRlAo1TqAzKZihUMfq5qNMQIDAQABAoIBAEs1TKF+Ui1VQKgm9LIzEAr1n4cCZ2KnC/EDzPTsqTiXtHUcwqO08GrGyuINHfFydo9Oy/LnWyPSLy3QSuyBUc93Wzi1+MqSi3qkaaXmaRmS5GsiolzqgwU+Y0Wbsefr2O/H/UxRmuTxetWYhiUH/9znSF8ZJkU7v44v8u1HS/GQOzncHdzStSKvjGbheIMHEtP/bEfX6X1i9LWn/S5LkY3awsubGCq/4lRCUuTS+O5V/V0jfVETsuQ3waSpFPs/LK6/0qXsFVckwcpH+2LNV8CpjfBJcksqvBW++dq8poBOemtYlAzgx03Do/cOTeLbCMh5RmqrK13t1L2puTzhAZECgYEA7mfsSdDZnGVgD4XmqnpxYb6QKPP3zBQoPK1J2wuvk3NiyJpe6KmAGoOMDnR3YvrGY+skXo5YYQ9aL3Sn/J/Zk8SnSbbOvZjUt+rHXum6RzU3Yk8IdjaXTCzJDBTfrRzzVXtFuGb/LvxTy+sN1oiWWVkQNnXNzQLv55o4CpcQnd0CgYEApgYNid9bPAW3OLx5nmPOX+7amkH1Vm1uVYY1UwBcAb/xYnIfz6A5vsWxNtOUyR3Muu0NM783gQhU7aEaDbqlYP3XuaeboKxffmohXqlDYY+fZwr9RY8GRSdYRJ9IC3vWg2LIgDRRU3iUcIJc5vNFik33j9tP+ChdeWeK1pVFiWUCgYEAmao+cS2+tcHZ8ud50DRv1HLB9MOb2ty7OrDvQ9L6bm4XI/nsZsaqHWzg34hOU2wUZ97uaEwTxyvgE2p7xKc71LUSpr6/7xENOyaHLzQzryYr9p++coOpbZ4IUFM8ARcB+P0l6T/qB1z4nh15o+gSELEJdDDmX9gezgdnS9wnB7kCgYAYJlc/z+KYh4hQU3IpbQEvCTJ5L9D9ImvjOuN00F+RzZbSKCGidP8RVfZiMEK7Qn9uTV8XQOBU/55C9qUwjA7UXfhMRCoqJAi7/boe5+YqQdcBCSMwRA64bnGzgavcJ8ZbVDowE+wkhSyqdPwIiCh8Zrz1CwTF5zE5oKscbZgw1QKBgQDZyHAAdWKPVvcSZ1JblRJilFUDnfsVLGvgejIlURhvFxRIUDlZJ0LfkJQO+0aziHGmcb9yTUR9tZlGQHFalzjKXBUDBO9yNruWsCptGWqgYYIj/wMuI2BXkPQtXNDo5fc5Ks9STLM3YfSj242ZYgUkqaA8AUJuziyLeORLsNoY6g==
3825f620-67d4-4736-8595-d4cdecf25e26	1a7472db-e2d8-4bf7-9540-d0d2d2be7bab	certificate	MIICmzCCAYMCBgFxDKw5kTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjAwMzI0MTMxMDQ1WhcNMzAwMzI0MTMxMjI1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCanQZDE8axSjFFAHbsRHgFondaNFx0PCb2vSm9WEuHEfTP7paSth0VbTv8TlgdGvU+2TckYUe6iCu/2WVbjl90ibntdZ3jrfpvu874Fy8EhWJhViM/67Lf2YXLO3HkPr13J2nmHgsWGDOk1YqXrb5+21oD8nSrEB+PDpWE6ZCgMoHS77bmIokreMuyGf99nchueBIzD56uoEO3oEFxUntQYpqcDY3cwRvd82y0JKmzj2JK5e/o0jziFih7wei5l77JfJM7EluIptpqmvjHw6TyTSahj1rBBbk6M1kmPRNjRiGCOGRJmqnXiSFYuZDWFmVGUCjVOoDMpmKFQx+rmo0xAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJTC56GuAfgo+G0IuC0KZA2nLEse6RSyCOyIJDHUZQop4b+NX8zwcW72gx4/MNleRJzBea3U01AaR3Pjbi/mklUMlDCbvs19uBwj7/G+ISwPovvvAmu8btgcp0Oz4yk3DBXmcwJaCl8P/kLAbBKo830gDpphS4hTqfPHW8+LLYDVZ1I1DkcUUm1Fbire++SGX7pMsukLzBHxS6B3z//v4HRRr3IsTiwRAxgHMtjFYtHD4gJ3aBnoU1MDFPF1YPYeFwCVHYzjYJDqUFSiDys1G4hhi+cl0eJSLyQtVCrnycUOHOEBNpouXfVFCWJksREBb2IfX/wr3UYsZyDL/+H75Ck=
80a96300-8408-4f5d-a505-1c25e692b88c	9c2ef544-efcd-4480-9224-75ee446905d7	secret	XbFhoQ8dxiPp4HiFhED-_Q
31677ce6-8f99-4477-9a05-1d288bc9fe86	9c2ef544-efcd-4480-9224-75ee446905d7	priority	100
dac23ace-c352-49f4-8811-4a3817c6b6f3	9c2ef544-efcd-4480-9224-75ee446905d7	kid	b4894594-b11d-45ab-b7c4-d78aeffa8e50
af10bfaa-7434-4a8a-8484-04ff38dc6811	2d209934-dbe8-4278-856e-fb24c2fd379d	secret	q3r2YFcf1G6wLTeIhf_9NizVdb7IMJVwWCdBQPhoWyKsy9O-sFn5-yAunuO09aWU290DSSg_AcmD1vTXzYR5PA
8c096a84-230f-4b2c-8409-799bf8aafb6d	2d209934-dbe8-4278-856e-fb24c2fd379d	algorithm	HS256
24800b4d-1d30-4498-84ed-79809b209259	2d209934-dbe8-4278-856e-fb24c2fd379d	kid	c92e0059-4c4b-4238-934a-d7095c870800
5ff4aa7a-ebaf-49b2-96de-4e9adbe78fbe	2d209934-dbe8-4278-856e-fb24c2fd379d	priority	100
34e86a40-2a9a-4898-b0cb-d880d034d5f6	846a68dd-361c-4f68-b2d0-0a47c9d5870a	privateKey	MIIEpAIBAAKCAQEAs2iY+UNfz035EspzTZUeSai+FbBQC487BLsWC/BA+d5b1UFVs0k1erXnqrFBWjKzgn10r3fMfPlPn8ffK8iEuvBEoJ5vnRaHRqjhIi1DZ+h1o5sC9qhty0p5k+Nu9i0rV/CpY6PkAQw/e7kXBMWhK8zM/TAsA0GQUOaZDm/4WeNUq2roMAX+fAJZfMFiI2/WRvBQKcTY1SB6wJhC9c5QhBgWs83XR9EGP6BxyzvJMroR0kMyb+B7ITWbzpKXuUWbhsxRWm0Mz2nwHo9jsREC03wN0CnD+vocCnKjLv/4Bqy9igwKBT2bpAssR0Y7p3v1QZmSO3D4OxUhhkoWBZBCyQIDAQABAoIBACxgCMZOpdoOvTaqoI5l/dHWTP3sWEAjs0NeSvu09z1WhHxg5qOrzfCGIcEUiseWltQF1+C2zvtyZwFsXITl2f6rAy5/QbgnJFqT1uuvKmb/FmnbI4aC7nVD/IJZ1M5LKddcjWk51mFz+BfQFiN2BoFg7KsLSTec9ecswlrR0ynYKINJQ+uq8OuEsBBoE5EYSrhzgwS4i5zxBBLUCl16J0bu+Zuw8F8kKn262OJUGI4HlILHtzkw+LP3fcqiqQuFo6hU1wRmGm4UHxPp6URZhCxaBSoH6pYABmqjmo3EpzDh5i48jh3kwU/sYLP1QqMjUZUq/d6IUBlh0HvCzzX2HgECgYEA5nKgT96x7bi3dlbF+oRQ//n9noSOnad26RdYFE++39QYNqoqYPgJcXae0uE+kCK29Zt1fskY3t2xtZ17RLlcbsdwWGs20vQqx45M8IOUmrZqXzniUfl08/wyLa6VCAJJUjix6qV5RHLCP5H+wBkMh4VLzBiXTiwMqPGcE7LwhWkCgYEAx00y9z+wqiqFGxm5hJk3Wa8s0cuwln/+5ZYLgqxusKF/cLA+OtXBrjaOGmT/vFx6dorxjRpZCAzOYahBfu6fb40ZVmBNNQVfe9J6huoaEq1RFOQ3Aturz3rHb7MoDli0SvDIomo9U0v6vaP4kqOZJEKYlWAvsWxGUUN8Frb7RmECgYEAk65bvDOb1RtuPyFGyM+o1RJRDRgoCTJ7ys7R/FpKmUhjqAyPEguCibsZ90yv+lC07VsOBg07qf9q1lew2o7rhHa9MXyr6q7dB3vTJMM+JZPHQXVn616xK3awdYQPL82/TTjWE+iteUcN4w1ds5+Z3vN2arpLpKYoCtCjVCB1cRkCgYEAh5RN0oMiRHCOgiQa30h3rewMOmAtrgQ+u6I6DFgPKNuEXX2Xp+CYVFJKk0wX6OSkbpYQwqOk42QK1cZnX9km3vUGworamvIfxZUmwzboK8J5wROLFMepdoiYubUPz8qqQ7zPUCWjuFGcrnuocuEWIeOn9x4q87CrmUamWLF7+KECgYBdBwZbawfYTX2NZxleqFjUXUalZUE/w31rPOnCJqhJ1Wwg/v+sqPuxSCN/yvws2CnF/Io4L3Yb7j0Mhj3b18tk9aD8UD7TRamE3AFItrHfOzeCuKDSSwQvErgOhZ1oLpUN1LgHdDFu9B+lv6IH7ARAPTNlHjUNMenUndiN2Rq0vA==
d5277770-b835-49a6-b1b7-1500462593e9	846a68dd-361c-4f68-b2d0-0a47c9d5870a	certificate	MIIClzCCAX8CBgFxDMCyCjANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTIwMDMyNDEzMzMwN1oXDTMwMDMyNDEzMzQ0N1owDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALNomPlDX89N+RLKc02VHkmovhWwUAuPOwS7FgvwQPneW9VBVbNJNXq156qxQVoys4J9dK93zHz5T5/H3yvIhLrwRKCeb50Wh0ao4SItQ2fodaObAvaobctKeZPjbvYtK1fwqWOj5AEMP3u5FwTFoSvMzP0wLANBkFDmmQ5v+FnjVKtq6DAF/nwCWXzBYiNv1kbwUCnE2NUgesCYQvXOUIQYFrPN10fRBj+gccs7yTK6EdJDMm/geyE1m86Sl7lFm4bMUVptDM9p8B6PY7ERAtN8DdApw/r6HApyoy7/+AasvYoMCgU9m6QLLEdGO6d79UGZkjtw+DsVIYZKFgWQQskCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAawlhG+TCBv+/Hn+5zKLDUrlWTfjdp7Nnfkr7fZTz9dpX9RrxZbwT3g421/tYH3GuAWymuzBG+rhWm/x4GG+8kyAc5saqaDhLKGqp8GBf22u+zrJeBLudexddmPy0CTx6vh5GIKOLs4DM0/xuZCwgMsSNrnCGmY5vbgIGi5v0V7PIIOQsfuw4u1y70OAyUk2UTm4U4X9A9YVNoSwwWOmOrOqVNf7ml+Co3Fq5cPjuuWCTYmR9VnB2yUTGNELERMqMzW+qnNGLIq5L9ylFbTrk+WiGcmyN36MgJepaRTodpSodngCc3gyAyDHd0QHgRTv72G2LbWEwoWUbdcm32Ql9KA==
2b30487f-4474-438c-ad84-2afaa8988822	846a68dd-361c-4f68-b2d0-0a47c9d5870a	priority	100
e2a05c3c-baa2-4f35-a244-1af56f706eb1	d7c1eeaf-ca8a-46d3-a04f-1df4e5379d84	priority	100
9c803cac-a3f5-43a9-8ad4-5169bb1235fd	d7c1eeaf-ca8a-46d3-a04f-1df4e5379d84	kid	3e014660-6ecd-494a-a185-a8406447c8bd
f60f32d1-9428-4e54-a69a-1262d895bd36	d7c1eeaf-ca8a-46d3-a04f-1df4e5379d84	secret	6jPeiUwX3G2eIRhvZEK_YE4kCUuDmQ0vcG6ZBKVFIlHd9tDNodKWlGXpeXrdiKe3q_cRFK5BoivCRMJeBxeKgA
603895c3-4445-49f9-a51f-11a8f33443fb	d7c1eeaf-ca8a-46d3-a04f-1df4e5379d84	algorithm	HS256
3775094f-7fff-437b-a272-6d3068053077	a6bf33e3-193e-45f1-a27f-bd36e8f7934a	kid	74f46f33-3fc4-45e0-a91a-84bd2311dbea
35be2a3c-a272-41a5-b903-ff0a32f821c5	a6bf33e3-193e-45f1-a27f-bd36e8f7934a	secret	m4u7vx9bx3V8VDZOyaPCmA
268576e0-e2f8-472d-b27c-c616552a2626	a6bf33e3-193e-45f1-a27f-bd36e8f7934a	priority	100
2ac9e9d4-1854-4bac-ba67-14ebfbb9830d	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	saml-user-attribute-mapper
45f430de-da3d-4962-ab6c-29067e7c5c6a	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	saml-role-list-mapper
3fab6fbb-fda2-4f97-ac38-b7522a505fa5	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	oidc-full-name-mapper
b1c70b5b-1119-419e-becb-ef748d331f16	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	oidc-address-mapper
3eb6ff7d-979c-407b-bd02-3b6c389598b0	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c2220b79-ccb3-4a5b-a06a-8179e2febff4	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3d5fda4f-c333-4d30-a76a-779d2923d15d	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	saml-user-property-mapper
0e0c9813-f34b-4a81-88c2-f81a39e1235c	e79c38d4-06c9-4085-af4e-3b98093aa81e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9670d50d-479b-4918-9e24-d83434d35c3c	800b0e12-1cc1-4a4d-bedd-a5d91482182d	allow-default-scopes	true
e7369d29-632f-41a8-a46b-9e40d2294d60	0977044a-cf50-4aa9-b926-c668b08cb6bb	max-clients	200
7e058114-7f26-4a66-b6dd-89fc14088e7a	a585fa3e-04fc-4349-b52b-8a9a1ef83206	allow-default-scopes	true
39839918-ad23-464d-a826-860d2c675216	cfaa532c-4507-4d04-b8ee-84541e01c0c6	host-sending-registration-request-must-match	true
2f7301d2-bd71-4dcb-a000-e84214ce73d1	cfaa532c-4507-4d04-b8ee-84541e01c0c6	client-uris-must-match	true
54a9edf8-fda5-4258-80e5-5b51bedbe2da	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
15709743-8cb6-4381-b770-3ac3223c389c	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	saml-user-attribute-mapper
da058e6b-2fd0-486e-a0b0-3ae0ae4da531	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	oidc-full-name-mapper
5b0ae20a-b5df-4335-8e01-3c38587b5504	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	oidc-address-mapper
58f1b338-2189-4f62-9f31-663e603193c2	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
7eab6edb-e73a-4d1c-a3ba-0f7f0acb243f	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4954394e-9d5e-4c73-b2fb-3e1f3e0ad9b1	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	saml-role-list-mapper
b06cfd59-e396-4906-9ea8-cd6b58ecd76d	f6e251fc-41e9-4399-baed-7d6d6e1e049f	allowed-protocol-mapper-types	saml-user-property-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
6920b008-f214-4ba2-a06a-fed8b0539bdc	86854b06-a9b9-4a5e-b745-bb2fec4e9f98
6920b008-f214-4ba2-a06a-fed8b0539bdc	2e5c75bd-235a-4cef-bce0-3ab00e7bb9a7
6920b008-f214-4ba2-a06a-fed8b0539bdc	bf5dd0c7-e183-4665-9478-e21781f0c586
6920b008-f214-4ba2-a06a-fed8b0539bdc	949b0784-2598-41b9-b8e1-681ca91c7443
6920b008-f214-4ba2-a06a-fed8b0539bdc	0927a913-5f37-44d4-b7a7-2784fc089aeb
6920b008-f214-4ba2-a06a-fed8b0539bdc	62c4467c-da92-4086-96e6-d15af3d93ad9
6920b008-f214-4ba2-a06a-fed8b0539bdc	6475eb07-324e-4046-9dd4-0f3a25d39587
6920b008-f214-4ba2-a06a-fed8b0539bdc	e3292c1c-db4f-46c7-8f3f-696ce669af57
6920b008-f214-4ba2-a06a-fed8b0539bdc	e566b9b2-ef8c-4179-8705-55af322f4d88
6920b008-f214-4ba2-a06a-fed8b0539bdc	92697edb-67ff-48b2-9ba4-af83b99a5601
6920b008-f214-4ba2-a06a-fed8b0539bdc	79a0f5e4-ca98-4171-9a31-7a0ff358f8d4
6920b008-f214-4ba2-a06a-fed8b0539bdc	2e2e788d-5511-424b-88d1-fe37e3e87e7d
6920b008-f214-4ba2-a06a-fed8b0539bdc	d54a12b6-20d5-4738-b345-d13b16bc6273
6920b008-f214-4ba2-a06a-fed8b0539bdc	9a59cf25-2e7d-4cf6-830a-9cc9a90a5f23
6920b008-f214-4ba2-a06a-fed8b0539bdc	7fdebdab-23ec-43a5-8134-7c04e8584981
6920b008-f214-4ba2-a06a-fed8b0539bdc	675bb55a-8f4b-4de2-a752-212a06861c87
6920b008-f214-4ba2-a06a-fed8b0539bdc	73aefaef-e649-44ff-ab5d-572842a596e7
6920b008-f214-4ba2-a06a-fed8b0539bdc	59db7806-042e-4a59-b2c3-a5046d3b6c11
949b0784-2598-41b9-b8e1-681ca91c7443	7fdebdab-23ec-43a5-8134-7c04e8584981
949b0784-2598-41b9-b8e1-681ca91c7443	59db7806-042e-4a59-b2c3-a5046d3b6c11
0927a913-5f37-44d4-b7a7-2784fc089aeb	675bb55a-8f4b-4de2-a752-212a06861c87
b3337f6f-5016-49cd-912b-517f30e5bc07	66602a0c-9923-4a32-9e80-6c76866bd1ee
6920b008-f214-4ba2-a06a-fed8b0539bdc	79255e7a-e127-4c43-968b-e6a57ce0eae3
6920b008-f214-4ba2-a06a-fed8b0539bdc	79a2d251-0375-4862-8258-329731008d14
6920b008-f214-4ba2-a06a-fed8b0539bdc	beb327fd-c657-4b1d-bb0c-1492057bc5ca
6920b008-f214-4ba2-a06a-fed8b0539bdc	2e9d707f-7553-45b6-aa95-657b0072cc0b
6920b008-f214-4ba2-a06a-fed8b0539bdc	ea10a364-8a2f-490f-99c6-3cf53914530c
6920b008-f214-4ba2-a06a-fed8b0539bdc	4ba6bcab-7908-4326-b979-a980bc9aefff
6920b008-f214-4ba2-a06a-fed8b0539bdc	f28a31e9-da06-496e-9559-53a4358096d3
6920b008-f214-4ba2-a06a-fed8b0539bdc	ed083ca2-bc60-457a-8a32-6a6eab219390
6920b008-f214-4ba2-a06a-fed8b0539bdc	b04966a4-0324-4a97-8d21-ebab30d7e18c
6920b008-f214-4ba2-a06a-fed8b0539bdc	4e5aead0-7a81-4373-b3d7-f5a4322e1344
6920b008-f214-4ba2-a06a-fed8b0539bdc	d38eaeb2-9020-4467-87ee-15b4afb081c8
6920b008-f214-4ba2-a06a-fed8b0539bdc	c7cae477-6ea6-4fbf-aa6b-c8766594c1af
6920b008-f214-4ba2-a06a-fed8b0539bdc	61cff945-5686-4454-ae1e-e70632cf51df
6920b008-f214-4ba2-a06a-fed8b0539bdc	78d6604d-981b-4509-a04e-1e3fbb35fff8
6920b008-f214-4ba2-a06a-fed8b0539bdc	15f05909-7204-4d1c-9bbb-ec27341efc74
6920b008-f214-4ba2-a06a-fed8b0539bdc	5956a9fd-5f72-474d-81f0-ec0f56d04dad
6920b008-f214-4ba2-a06a-fed8b0539bdc	2fcc6ece-d989-4a49-8e30-1e4519283568
6920b008-f214-4ba2-a06a-fed8b0539bdc	6824c5f2-fd1c-4f32-a88f-bcb68178ae2a
2e9d707f-7553-45b6-aa95-657b0072cc0b	15f05909-7204-4d1c-9bbb-ec27341efc74
2e9d707f-7553-45b6-aa95-657b0072cc0b	6824c5f2-fd1c-4f32-a88f-bcb68178ae2a
ea10a364-8a2f-490f-99c6-3cf53914530c	5956a9fd-5f72-474d-81f0-ec0f56d04dad
28c61854-e356-48de-92cd-d52ce71685c7	97c0dcb1-3f6c-4d7e-8712-dbfc0ac36f3e
28c61854-e356-48de-92cd-d52ce71685c7	7a35c622-a058-427e-9779-72454810d90b
28c61854-e356-48de-92cd-d52ce71685c7	ae3456cf-8066-47cb-9edd-77d8e73db7e4
28c61854-e356-48de-92cd-d52ce71685c7	8ab46137-686e-43c6-b340-47a5bb9b98d3
28c61854-e356-48de-92cd-d52ce71685c7	3c76dcdb-5fd0-4ae9-afc7-ef7d38f2dbbb
28c61854-e356-48de-92cd-d52ce71685c7	f7010182-23f4-43f2-892a-82900a8865d5
28c61854-e356-48de-92cd-d52ce71685c7	4cc16a60-b3e2-41c4-b72d-9c77d3b47c57
28c61854-e356-48de-92cd-d52ce71685c7	dd223aa5-8072-4415-9387-9ded8c0245e5
28c61854-e356-48de-92cd-d52ce71685c7	4fff674d-36c5-49da-a80f-2b7832332c2d
28c61854-e356-48de-92cd-d52ce71685c7	8414547b-b9ad-43a6-af3d-66e826753a92
28c61854-e356-48de-92cd-d52ce71685c7	57afecd0-6a1e-42db-a7f6-222605d16732
28c61854-e356-48de-92cd-d52ce71685c7	1f06229c-807c-4689-82d0-ffc1c69727a3
28c61854-e356-48de-92cd-d52ce71685c7	291dd9db-a1dd-4f21-b48d-6d9d8b8e0aa7
28c61854-e356-48de-92cd-d52ce71685c7	afce20ee-0d6e-4433-bb67-9f59a9e0bb05
28c61854-e356-48de-92cd-d52ce71685c7	84c5de6b-ac36-4f78-8d40-04e4cb7d1af9
28c61854-e356-48de-92cd-d52ce71685c7	58f0b72c-d6f5-4a9f-a2b9-c7a1701878d3
28c61854-e356-48de-92cd-d52ce71685c7	1c003bb4-47a9-42aa-8c49-e3d94f6e4f9e
ae3456cf-8066-47cb-9edd-77d8e73db7e4	1c003bb4-47a9-42aa-8c49-e3d94f6e4f9e
ae3456cf-8066-47cb-9edd-77d8e73db7e4	afce20ee-0d6e-4433-bb67-9f59a9e0bb05
8ab46137-686e-43c6-b340-47a5bb9b98d3	84c5de6b-ac36-4f78-8d40-04e4cb7d1af9
6920b008-f214-4ba2-a06a-fed8b0539bdc	c34abc39-967a-4329-b276-9be636cb437e
82fbe66e-a7b7-44ec-ae66-72746eb06f04	d35cc949-5450-468f-bc9a-67d61a249749
28c61854-e356-48de-92cd-d52ce71685c7	265fa242-a1b7-4eb8-99b7-31ca8f9f76d8
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
d70a7829-a8d8-4984-aace-24a691c24f98	\N	password	86d125d1-da32-41af-b792-1c1fa4693efc	1585055547624	\N	{"value":"jwErY9YILIGX8KSzroraJaH8+oYNiyuDyyIRk/j53+IiAjNTXKHT+PGGTtfiNQ9RfcRVfko6jR1kH4Qswi4qTw==","salt":"JfgQy4BMco3Ow5oPA5AFTg=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
ebd78b1c-01ff-457c-ae75-d3b4aa8e6042	\N	password	78c5cfa9-3e79-4079-9fe7-5ef3eeb0ce5b	1585057626655	\N	{"value":"ljqHkJo25sRNFxjnqbU6OqdDE/R2VcZtZQp/IgYusFdVArB+eyN7bwlJjorTL70qG02P1D7Fb/sJCeRHVT4F5g==","salt":"uvXQsjGH+1t3SzzVH0wAqw=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
3fcf7863-2f57-45a5-9196-5e35dd2e4b0c	\N	password	6418686e-f9e2-424d-b7c1-481bca508500	1586886119872	\N	{"value":"vhpr96GAA/Ie4ygRulu861PnPz2LjEX9pfxfw+wDA8PNRepDZGuQV5VO8fCgq/VTb2sGmS8o5xL8GWee8DL+Sw==","salt":"p3SyLLh4psOBJSilWi+lVA=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2020-03-24 13:12:07.980947	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5055527014
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2020-03-24 13:12:08.067104	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	5055527014
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2020-03-24 13:12:08.174902	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	5055527014
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2020-03-24 13:12:08.197991	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	5055527014
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2020-03-24 13:12:08.46945	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5055527014
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2020-03-24 13:12:08.485578	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	5055527014
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2020-03-24 13:12:08.778457	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5055527014
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2020-03-24 13:12:08.789636	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	5055527014
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2020-03-24 13:12:08.816707	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	5055527014
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2020-03-24 13:12:09.146749	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	5055527014
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2020-03-24 13:12:09.342839	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5055527014
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2020-03-24 13:12:09.374414	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5055527014
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2020-03-24 13:12:09.460251	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	5055527014
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-24 13:12:09.519039	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	5055527014
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-24 13:12:09.525803	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5055527014
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-24 13:12:09.531822	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	5055527014
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-24 13:12:09.537317	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	5055527014
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2020-03-24 13:12:09.698109	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	5055527014
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2020-03-24 13:12:09.811456	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5055527014
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2020-03-24 13:12:09.823109	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5055527014
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-24 13:12:11.463409	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5055527014
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2020-03-24 13:12:09.832513	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	5055527014
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2020-03-24 13:12:09.851018	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	5055527014
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2020-03-24 13:12:09.935195	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	5055527014
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2020-03-24 13:12:09.945831	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5055527014
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2020-03-24 13:12:09.950254	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	5055527014
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2020-03-24 13:12:10.05238	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	5055527014
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2020-03-24 13:12:10.32547	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	5055527014
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2020-03-24 13:12:10.347306	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5055527014
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2020-03-24 13:12:10.588881	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	5055527014
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2020-03-24 13:12:10.672548	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	5055527014
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2020-03-24 13:12:10.719397	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	5055527014
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2020-03-24 13:12:10.733622	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	5055527014
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-24 13:12:10.763632	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	5055527014
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-24 13:12:10.776398	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5055527014
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-24 13:12:10.855789	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	5055527014
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2020-03-24 13:12:10.872858	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	5055527014
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-24 13:12:10.889322	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	5055527014
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2020-03-24 13:12:10.900352	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	5055527014
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2020-03-24 13:12:10.914271	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	5055527014
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-24 13:12:10.923821	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5055527014
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-24 13:12:10.930033	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	5055527014
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2020-03-24 13:12:10.961113	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	5055527014
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-24 13:12:11.426601	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	5055527014
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2020-03-24 13:12:11.438156	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	5055527014
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-24 13:12:11.482108	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	5055527014
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-24 13:12:11.497376	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	5055527014
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-24 13:12:11.644619	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	5055527014
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-24 13:12:11.684052	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	5055527014
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2020-03-24 13:12:11.854842	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	5055527014
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2020-03-24 13:12:11.972233	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	5055527014
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2020-03-24 13:12:11.981835	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	5055527014
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2020-03-24 13:12:11.987779	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	5055527014
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2020-03-24 13:12:11.99936	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	5055527014
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-24 13:12:12.017648	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	5055527014
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-24 13:12:12.030026	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	5055527014
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-24 13:12:12.128119	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	5055527014
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-24 13:12:12.603782	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	5055527014
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2020-03-24 13:12:12.674926	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	5055527014
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2020-03-24 13:12:12.687309	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	5055527014
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-03-24 13:12:12.714942	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	5055527014
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-03-24 13:12:12.736913	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	5055527014
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2020-03-24 13:12:12.747009	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5055527014
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2020-03-24 13:12:12.758859	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	5055527014
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2020-03-24 13:12:12.765004	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	5055527014
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2020-03-24 13:12:12.80364	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	5055527014
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2020-03-24 13:12:12.819179	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	5055527014
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2020-03-24 13:12:12.831455	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	5055527014
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2020-03-24 13:12:12.865162	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	5055527014
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2020-03-24 13:12:12.884847	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	5055527014
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2020-03-24 13:12:12.899529	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	5055527014
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-24 13:12:12.926521	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5055527014
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-24 13:12:12.937245	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5055527014
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-24 13:12:12.942289	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	5055527014
8.0.0-credential-cleanup	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-24 13:12:12.97613	75	EXECUTED	7:41f3566ac5177459e1ed3ce8f0ad35d2	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	5055527014
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-24 13:12:12.994022	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	5055527014
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	a71ddb95-2806-4c0e-a356-1661b0799afd	f
master	d8cfba15-e4ac-4e31-983d-955b03ac2dfa	t
master	227bad54-a26e-4539-8d18-b3bb4c5435cb	t
master	5e31b682-00c0-495b-ac0a-b97e8826798e	t
master	32a3efe1-adc1-4209-999b-9ee5c33be537	f
master	caf270d3-02ad-4d34-9fbb-746bb7bc4668	f
master	f79fb725-9337-4d02-834e-e971e4593836	t
master	d2dc6f42-56af-4d59-a92a-ce10eb52b34d	t
master	68076ec8-04cb-40b7-b571-0b668632a2d0	f
test	e942a88e-2f6f-41bc-a73f-dd7bb2e65757	f
test	81a2c111-5a04-42b7-8792-38ee44689e07	t
test	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8	t
test	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681	t
test	a6b9823c-361f-42b9-8ee0-44c113f4e30f	f
test	8893628d-2430-4c5f-af96-3653480a307d	f
test	85309e05-6c1b-44ac-90e3-8607f836a07b	t
test	088c8b28-fb69-4cbe-af4c-f5caee3c6df2	t
test	de45c7c1-4c48-49d0-a94f-ddfd560eaeed	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
6920b008-f214-4ba2-a06a-fed8b0539bdc	master	f	${role_admin}	admin	master	\N	master
86854b06-a9b9-4a5e-b745-bb2fec4e9f98	master	f	${role_create-realm}	create-realm	master	\N	master
2e5c75bd-235a-4cef-bce0-3ab00e7bb9a7	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_create-client}	create-client	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
bf5dd0c7-e183-4665-9478-e21781f0c586	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_view-realm}	view-realm	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
949b0784-2598-41b9-b8e1-681ca91c7443	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_view-users}	view-users	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
0927a913-5f37-44d4-b7a7-2784fc089aeb	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_view-clients}	view-clients	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
62c4467c-da92-4086-96e6-d15af3d93ad9	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_view-events}	view-events	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
6475eb07-324e-4046-9dd4-0f3a25d39587	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_view-identity-providers}	view-identity-providers	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
e3292c1c-db4f-46c7-8f3f-696ce669af57	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_view-authorization}	view-authorization	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
e566b9b2-ef8c-4179-8705-55af322f4d88	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_manage-realm}	manage-realm	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
92697edb-67ff-48b2-9ba4-af83b99a5601	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_manage-users}	manage-users	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
79a0f5e4-ca98-4171-9a31-7a0ff358f8d4	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_manage-clients}	manage-clients	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
2e2e788d-5511-424b-88d1-fe37e3e87e7d	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_manage-events}	manage-events	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
d54a12b6-20d5-4738-b345-d13b16bc6273	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_manage-identity-providers}	manage-identity-providers	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
9a59cf25-2e7d-4cf6-830a-9cc9a90a5f23	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_manage-authorization}	manage-authorization	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
7fdebdab-23ec-43a5-8134-7c04e8584981	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_query-users}	query-users	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
675bb55a-8f4b-4de2-a752-212a06861c87	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_query-clients}	query-clients	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
73aefaef-e649-44ff-ab5d-572842a596e7	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_query-realms}	query-realms	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
59db7806-042e-4a59-b2c3-a5046d3b6c11	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_query-groups}	query-groups	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
917ce590-59c7-4a05-b488-7735cae4452d	ea3b6386-3a19-4970-8b4e-be48fe310294	t	${role_view-profile}	view-profile	master	ea3b6386-3a19-4970-8b4e-be48fe310294	\N
b3337f6f-5016-49cd-912b-517f30e5bc07	ea3b6386-3a19-4970-8b4e-be48fe310294	t	${role_manage-account}	manage-account	master	ea3b6386-3a19-4970-8b4e-be48fe310294	\N
66602a0c-9923-4a32-9e80-6c76866bd1ee	ea3b6386-3a19-4970-8b4e-be48fe310294	t	${role_manage-account-links}	manage-account-links	master	ea3b6386-3a19-4970-8b4e-be48fe310294	\N
5b1b4f6e-cd9f-42f7-9e92-539795a5a6e3	f50e49e4-eed0-4377-864c-6e5e238a0701	t	${role_read-token}	read-token	master	f50e49e4-eed0-4377-864c-6e5e238a0701	\N
79255e7a-e127-4c43-968b-e6a57ce0eae3	abc7f818-4fd6-4b54-a3c6-48b18c789c00	t	${role_impersonation}	impersonation	master	abc7f818-4fd6-4b54-a3c6-48b18c789c00	\N
c93975fb-d01d-46de-ba8a-3cf949e09db1	master	f	${role_offline-access}	offline_access	master	\N	master
aded55b8-84b5-469d-bfa7-ae7d29bedf8b	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
79a2d251-0375-4862-8258-329731008d14	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_create-client}	create-client	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
beb327fd-c657-4b1d-bb0c-1492057bc5ca	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_view-realm}	view-realm	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
2e9d707f-7553-45b6-aa95-657b0072cc0b	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_view-users}	view-users	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
ea10a364-8a2f-490f-99c6-3cf53914530c	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_view-clients}	view-clients	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
4ba6bcab-7908-4326-b979-a980bc9aefff	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_view-events}	view-events	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
f28a31e9-da06-496e-9559-53a4358096d3	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_view-identity-providers}	view-identity-providers	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
ed083ca2-bc60-457a-8a32-6a6eab219390	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_view-authorization}	view-authorization	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
b04966a4-0324-4a97-8d21-ebab30d7e18c	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_manage-realm}	manage-realm	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
4e5aead0-7a81-4373-b3d7-f5a4322e1344	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_manage-users}	manage-users	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
d38eaeb2-9020-4467-87ee-15b4afb081c8	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_manage-clients}	manage-clients	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
c7cae477-6ea6-4fbf-aa6b-c8766594c1af	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_manage-events}	manage-events	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
61cff945-5686-4454-ae1e-e70632cf51df	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_manage-identity-providers}	manage-identity-providers	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
78d6604d-981b-4509-a04e-1e3fbb35fff8	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_manage-authorization}	manage-authorization	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
15f05909-7204-4d1c-9bbb-ec27341efc74	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_query-users}	query-users	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
5956a9fd-5f72-474d-81f0-ec0f56d04dad	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_query-clients}	query-clients	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
2fcc6ece-d989-4a49-8e30-1e4519283568	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_query-realms}	query-realms	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
6824c5f2-fd1c-4f32-a88f-bcb68178ae2a	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_query-groups}	query-groups	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
28c61854-e356-48de-92cd-d52ce71685c7	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_realm-admin}	realm-admin	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
97c0dcb1-3f6c-4d7e-8712-dbfc0ac36f3e	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_create-client}	create-client	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
7a35c622-a058-427e-9779-72454810d90b	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_view-realm}	view-realm	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
ae3456cf-8066-47cb-9edd-77d8e73db7e4	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_view-users}	view-users	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
8ab46137-686e-43c6-b340-47a5bb9b98d3	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_view-clients}	view-clients	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
3c76dcdb-5fd0-4ae9-afc7-ef7d38f2dbbb	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_view-events}	view-events	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
f7010182-23f4-43f2-892a-82900a8865d5	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_view-identity-providers}	view-identity-providers	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
4cc16a60-b3e2-41c4-b72d-9c77d3b47c57	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_view-authorization}	view-authorization	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
dd223aa5-8072-4415-9387-9ded8c0245e5	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_manage-realm}	manage-realm	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
4fff674d-36c5-49da-a80f-2b7832332c2d	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_manage-users}	manage-users	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
8414547b-b9ad-43a6-af3d-66e826753a92	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_manage-clients}	manage-clients	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
57afecd0-6a1e-42db-a7f6-222605d16732	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_manage-events}	manage-events	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
1f06229c-807c-4689-82d0-ffc1c69727a3	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_manage-identity-providers}	manage-identity-providers	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
291dd9db-a1dd-4f21-b48d-6d9d8b8e0aa7	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_manage-authorization}	manage-authorization	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
afce20ee-0d6e-4433-bb67-9f59a9e0bb05	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_query-users}	query-users	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
84c5de6b-ac36-4f78-8d40-04e4cb7d1af9	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_query-clients}	query-clients	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
58f0b72c-d6f5-4a9f-a2b9-c7a1701878d3	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_query-realms}	query-realms	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
1c003bb4-47a9-42aa-8c49-e3d94f6e4f9e	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_query-groups}	query-groups	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
c1fa9ff0-acb6-4c1e-b4a5-2b6ed40138f5	d92ffcff-af21-4144-b731-a89bd59cdf5e	t	${role_view-profile}	view-profile	test	d92ffcff-af21-4144-b731-a89bd59cdf5e	\N
82fbe66e-a7b7-44ec-ae66-72746eb06f04	d92ffcff-af21-4144-b731-a89bd59cdf5e	t	${role_manage-account}	manage-account	test	d92ffcff-af21-4144-b731-a89bd59cdf5e	\N
d35cc949-5450-468f-bc9a-67d61a249749	d92ffcff-af21-4144-b731-a89bd59cdf5e	t	${role_manage-account-links}	manage-account-links	test	d92ffcff-af21-4144-b731-a89bd59cdf5e	\N
c34abc39-967a-4329-b276-9be636cb437e	8da5b847-e08a-4416-b7bb-19da50324f32	t	${role_impersonation}	impersonation	master	8da5b847-e08a-4416-b7bb-19da50324f32	\N
265fa242-a1b7-4eb8-99b7-31ca8f9f76d8	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	t	${role_impersonation}	impersonation	test	b20abab0-f5e5-42ea-b79e-0dbdf11484ba	\N
d384eab0-d14f-449b-9029-a86e8df00829	485585ef-7faf-4d8b-8e57-b663ae3b4265	t	${role_read-token}	read-token	test	485585ef-7faf-4d8b-8e57-b663ae3b4265	\N
d5eb4e92-88e2-4bfc-b11a-e3a338d12953	test	f	${role_offline-access}	offline_access	test	\N	test
5450836e-a708-41d5-ac90-90817402c19b	test	f	${role_uma_authorization}	uma_authorization	test	\N	test
ae8689e0-b63d-4c5e-94bb-0afe941fa629	test	f	\N	admin	test	\N	test
25a3c840-57bd-4a4a-a45b-bdb6163c4f02	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	t	\N	uma_protection	test	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
lvgsq	8.0.1	1585055541
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
df81f3cf-7ab2-4ccc-81ad-629e1bd18607	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
1bbf642d-6b3c-43af-9790-1608634881c7	defaultResourceType	urn:kong:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
0cb1fc1e-ce18-462e-be3e-ec393e5fb226	locale	openid-connect	oidc-usermodel-attribute-mapper	211b769c-3db2-420a-93a3-aee2d24990b1	\N
a91c1d85-4510-4af3-8f4b-22f83bf00c3f	role list	saml	saml-role-list-mapper	\N	d8cfba15-e4ac-4e31-983d-955b03ac2dfa
3746042e-a5b9-405f-8bc3-991998820597	full name	openid-connect	oidc-full-name-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
34029471-92be-4528-b1e3-6bfe72df589d	family name	openid-connect	oidc-usermodel-property-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
7b2c6e02-d621-4a72-a19d-54c07a7a17d6	given name	openid-connect	oidc-usermodel-property-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
2eb82246-309d-44ee-98a0-8d47917fd5c1	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
692248c6-39ca-44be-b984-dc65dd5336a6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
9f08a461-9ef7-4413-b82a-7b12867a6c8d	username	openid-connect	oidc-usermodel-property-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
7bc33b6b-e828-4cc9-80fd-3beb359c2ea9	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
610dc30a-b9ea-4b39-9925-acad305425d4	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
de712f7d-7779-4930-90bd-ccda847c8625	website	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
2d4f6351-10c9-43c1-b841-b2f65a5fd0ba	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
095cf2d0-4f22-4f40-9839-ea0074814042	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
cff090c1-9199-4aa1-963a-40c5d39786b3	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
f3cada27-efec-4692-8336-9f426b18a62b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
a48b03b7-8cb6-43a7-8665-4d4a1a560fd1	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	227bad54-a26e-4539-8d18-b3bb4c5435cb
d8aebd7b-be98-4994-bafe-8f68dc58e2cd	email	openid-connect	oidc-usermodel-property-mapper	\N	5e31b682-00c0-495b-ac0a-b97e8826798e
683f9b16-ab60-422b-b1d8-8c64ae81a0b7	email verified	openid-connect	oidc-usermodel-property-mapper	\N	5e31b682-00c0-495b-ac0a-b97e8826798e
e8c13c08-5be8-429c-ae49-fc3a97c696a4	address	openid-connect	oidc-address-mapper	\N	32a3efe1-adc1-4209-999b-9ee5c33be537
d6ec1d5c-3f9c-428e-9b8a-6dde0a95051c	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	caf270d3-02ad-4d34-9fbb-746bb7bc4668
d835a6c4-4835-46f4-b9be-f7e252473a4f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	caf270d3-02ad-4d34-9fbb-746bb7bc4668
02fd33b9-d956-44e5-a2f2-ed8196bf75ac	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f79fb725-9337-4d02-834e-e971e4593836
ecc39105-1128-4b9f-8669-1b583fe5c95c	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f79fb725-9337-4d02-834e-e971e4593836
15e9c786-8dca-4863-8866-7b95845811e1	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f79fb725-9337-4d02-834e-e971e4593836
bf015c84-a3fd-4ad6-9608-b8bd885c62a7	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	d2dc6f42-56af-4d59-a92a-ce10eb52b34d
100cf8dd-1037-4fb6-9394-a6857dcb962f	upn	openid-connect	oidc-usermodel-property-mapper	\N	68076ec8-04cb-40b7-b571-0b668632a2d0
0f943d79-eb2b-47d2-a7e1-3dca18f9dfc9	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	68076ec8-04cb-40b7-b571-0b668632a2d0
501bd85e-911b-4ab1-8a88-27c47c3df2f8	role list	saml	saml-role-list-mapper	\N	81a2c111-5a04-42b7-8792-38ee44689e07
d452527f-ad84-4749-a463-50956f0711b1	full name	openid-connect	oidc-full-name-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
a847ed3f-fe20-45b5-96f7-85a19e4e9922	family name	openid-connect	oidc-usermodel-property-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
2aba8c18-4405-4270-850f-2d97b934ea33	given name	openid-connect	oidc-usermodel-property-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
a822cddc-23cb-4660-b445-58366c03bbab	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
9e4cb13d-59f5-4ed7-916c-8089750828b6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
cb27e260-f34c-4c2f-bbca-0da14fda109b	username	openid-connect	oidc-usermodel-property-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
53bd1bd8-25df-482f-baba-e6843e91c2c6	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
dd78b304-2313-41ad-bc02-0644eb7e11f8	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
602a8772-dc37-432a-bc8a-0183de719111	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
2b7ad4e4-6c5c-4189-b44d-aef1b504680f	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
b0851f64-ccab-48c0-a097-6ea7406cf780	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
72d27071-40d0-4b03-a312-3a547bf3e8c0	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
17cd328f-1c60-4af2-9b23-ee9708a26083	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
4645296f-45e8-49d8-992f-8b1853d41729	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e6bd1a65-ee1f-446c-be21-3c7d9a4deff8
c2100c1d-4315-4215-a6f3-779563687781	email	openid-connect	oidc-usermodel-property-mapper	\N	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681
9fe4b022-da93-4404-b530-043c0eb89c91	email verified	openid-connect	oidc-usermodel-property-mapper	\N	423e2bd4-fe6c-4abe-86b8-ee7efcdf6681
ec8e385a-efad-4577-9e80-7ba19484cf05	address	openid-connect	oidc-address-mapper	\N	a6b9823c-361f-42b9-8ee0-44c113f4e30f
9ee19065-bc47-44c4-a2c2-7c6894297ab5	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8893628d-2430-4c5f-af96-3653480a307d
a0d08760-0f24-478d-a1ff-9d067c25598a	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8893628d-2430-4c5f-af96-3653480a307d
120e1b1e-780a-42dd-b636-5ba182ed6c8e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	85309e05-6c1b-44ac-90e3-8607f836a07b
c48e9b4a-7722-47a3-81ab-d6eeb6786aba	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	85309e05-6c1b-44ac-90e3-8607f836a07b
e9b3f05a-fd75-4c03-a125-42aa4066e107	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	85309e05-6c1b-44ac-90e3-8607f836a07b
c55757c1-1008-4d2a-92d4-33cfb9cf8a03	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	088c8b28-fb69-4cbe-af4c-f5caee3c6df2
dc5dced8-923d-4be2-a6e0-b5b1d3dd5755	upn	openid-connect	oidc-usermodel-property-mapper	\N	de45c7c1-4c48-49d0-a94f-ddfd560eaeed
3ce96f0b-4da0-40c6-947a-216bfae59ff3	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	de45c7c1-4c48-49d0-a94f-ddfd560eaeed
771a0d2e-4731-4b8a-b773-3394d6e23579	locale	openid-connect	oidc-usermodel-attribute-mapper	810c10be-2cca-472b-9785-23a7e2668a9c	\N
d0c1824a-551f-4d7f-ac7d-c2ad29ed73ab	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	\N
47498844-756e-4bd5-90eb-9ce1bdb92476	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	\N
58ea770f-b0b0-4cc8-a71f-d0ee0eeccb12	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
0cb1fc1e-ce18-462e-be3e-ec393e5fb226	true	userinfo.token.claim
0cb1fc1e-ce18-462e-be3e-ec393e5fb226	locale	user.attribute
0cb1fc1e-ce18-462e-be3e-ec393e5fb226	true	id.token.claim
0cb1fc1e-ce18-462e-be3e-ec393e5fb226	true	access.token.claim
0cb1fc1e-ce18-462e-be3e-ec393e5fb226	locale	claim.name
0cb1fc1e-ce18-462e-be3e-ec393e5fb226	String	jsonType.label
a91c1d85-4510-4af3-8f4b-22f83bf00c3f	false	single
a91c1d85-4510-4af3-8f4b-22f83bf00c3f	Basic	attribute.nameformat
a91c1d85-4510-4af3-8f4b-22f83bf00c3f	Role	attribute.name
3746042e-a5b9-405f-8bc3-991998820597	true	userinfo.token.claim
3746042e-a5b9-405f-8bc3-991998820597	true	id.token.claim
3746042e-a5b9-405f-8bc3-991998820597	true	access.token.claim
34029471-92be-4528-b1e3-6bfe72df589d	true	userinfo.token.claim
34029471-92be-4528-b1e3-6bfe72df589d	lastName	user.attribute
34029471-92be-4528-b1e3-6bfe72df589d	true	id.token.claim
34029471-92be-4528-b1e3-6bfe72df589d	true	access.token.claim
34029471-92be-4528-b1e3-6bfe72df589d	family_name	claim.name
34029471-92be-4528-b1e3-6bfe72df589d	String	jsonType.label
7b2c6e02-d621-4a72-a19d-54c07a7a17d6	true	userinfo.token.claim
7b2c6e02-d621-4a72-a19d-54c07a7a17d6	firstName	user.attribute
7b2c6e02-d621-4a72-a19d-54c07a7a17d6	true	id.token.claim
7b2c6e02-d621-4a72-a19d-54c07a7a17d6	true	access.token.claim
7b2c6e02-d621-4a72-a19d-54c07a7a17d6	given_name	claim.name
7b2c6e02-d621-4a72-a19d-54c07a7a17d6	String	jsonType.label
2eb82246-309d-44ee-98a0-8d47917fd5c1	true	userinfo.token.claim
2eb82246-309d-44ee-98a0-8d47917fd5c1	middleName	user.attribute
2eb82246-309d-44ee-98a0-8d47917fd5c1	true	id.token.claim
2eb82246-309d-44ee-98a0-8d47917fd5c1	true	access.token.claim
2eb82246-309d-44ee-98a0-8d47917fd5c1	middle_name	claim.name
2eb82246-309d-44ee-98a0-8d47917fd5c1	String	jsonType.label
692248c6-39ca-44be-b984-dc65dd5336a6	true	userinfo.token.claim
692248c6-39ca-44be-b984-dc65dd5336a6	nickname	user.attribute
692248c6-39ca-44be-b984-dc65dd5336a6	true	id.token.claim
692248c6-39ca-44be-b984-dc65dd5336a6	true	access.token.claim
692248c6-39ca-44be-b984-dc65dd5336a6	nickname	claim.name
692248c6-39ca-44be-b984-dc65dd5336a6	String	jsonType.label
9f08a461-9ef7-4413-b82a-7b12867a6c8d	true	userinfo.token.claim
9f08a461-9ef7-4413-b82a-7b12867a6c8d	username	user.attribute
9f08a461-9ef7-4413-b82a-7b12867a6c8d	true	id.token.claim
9f08a461-9ef7-4413-b82a-7b12867a6c8d	true	access.token.claim
9f08a461-9ef7-4413-b82a-7b12867a6c8d	preferred_username	claim.name
9f08a461-9ef7-4413-b82a-7b12867a6c8d	String	jsonType.label
7bc33b6b-e828-4cc9-80fd-3beb359c2ea9	true	userinfo.token.claim
7bc33b6b-e828-4cc9-80fd-3beb359c2ea9	profile	user.attribute
7bc33b6b-e828-4cc9-80fd-3beb359c2ea9	true	id.token.claim
7bc33b6b-e828-4cc9-80fd-3beb359c2ea9	true	access.token.claim
7bc33b6b-e828-4cc9-80fd-3beb359c2ea9	profile	claim.name
7bc33b6b-e828-4cc9-80fd-3beb359c2ea9	String	jsonType.label
610dc30a-b9ea-4b39-9925-acad305425d4	true	userinfo.token.claim
610dc30a-b9ea-4b39-9925-acad305425d4	picture	user.attribute
610dc30a-b9ea-4b39-9925-acad305425d4	true	id.token.claim
610dc30a-b9ea-4b39-9925-acad305425d4	true	access.token.claim
610dc30a-b9ea-4b39-9925-acad305425d4	picture	claim.name
610dc30a-b9ea-4b39-9925-acad305425d4	String	jsonType.label
de712f7d-7779-4930-90bd-ccda847c8625	true	userinfo.token.claim
de712f7d-7779-4930-90bd-ccda847c8625	website	user.attribute
de712f7d-7779-4930-90bd-ccda847c8625	true	id.token.claim
de712f7d-7779-4930-90bd-ccda847c8625	true	access.token.claim
de712f7d-7779-4930-90bd-ccda847c8625	website	claim.name
de712f7d-7779-4930-90bd-ccda847c8625	String	jsonType.label
2d4f6351-10c9-43c1-b841-b2f65a5fd0ba	true	userinfo.token.claim
2d4f6351-10c9-43c1-b841-b2f65a5fd0ba	gender	user.attribute
2d4f6351-10c9-43c1-b841-b2f65a5fd0ba	true	id.token.claim
2d4f6351-10c9-43c1-b841-b2f65a5fd0ba	true	access.token.claim
2d4f6351-10c9-43c1-b841-b2f65a5fd0ba	gender	claim.name
2d4f6351-10c9-43c1-b841-b2f65a5fd0ba	String	jsonType.label
095cf2d0-4f22-4f40-9839-ea0074814042	true	userinfo.token.claim
095cf2d0-4f22-4f40-9839-ea0074814042	birthdate	user.attribute
095cf2d0-4f22-4f40-9839-ea0074814042	true	id.token.claim
095cf2d0-4f22-4f40-9839-ea0074814042	true	access.token.claim
095cf2d0-4f22-4f40-9839-ea0074814042	birthdate	claim.name
095cf2d0-4f22-4f40-9839-ea0074814042	String	jsonType.label
cff090c1-9199-4aa1-963a-40c5d39786b3	true	userinfo.token.claim
cff090c1-9199-4aa1-963a-40c5d39786b3	zoneinfo	user.attribute
cff090c1-9199-4aa1-963a-40c5d39786b3	true	id.token.claim
cff090c1-9199-4aa1-963a-40c5d39786b3	true	access.token.claim
cff090c1-9199-4aa1-963a-40c5d39786b3	zoneinfo	claim.name
cff090c1-9199-4aa1-963a-40c5d39786b3	String	jsonType.label
f3cada27-efec-4692-8336-9f426b18a62b	true	userinfo.token.claim
f3cada27-efec-4692-8336-9f426b18a62b	locale	user.attribute
f3cada27-efec-4692-8336-9f426b18a62b	true	id.token.claim
f3cada27-efec-4692-8336-9f426b18a62b	true	access.token.claim
f3cada27-efec-4692-8336-9f426b18a62b	locale	claim.name
f3cada27-efec-4692-8336-9f426b18a62b	String	jsonType.label
a48b03b7-8cb6-43a7-8665-4d4a1a560fd1	true	userinfo.token.claim
a48b03b7-8cb6-43a7-8665-4d4a1a560fd1	updatedAt	user.attribute
a48b03b7-8cb6-43a7-8665-4d4a1a560fd1	true	id.token.claim
a48b03b7-8cb6-43a7-8665-4d4a1a560fd1	true	access.token.claim
a48b03b7-8cb6-43a7-8665-4d4a1a560fd1	updated_at	claim.name
a48b03b7-8cb6-43a7-8665-4d4a1a560fd1	String	jsonType.label
d8aebd7b-be98-4994-bafe-8f68dc58e2cd	true	userinfo.token.claim
d8aebd7b-be98-4994-bafe-8f68dc58e2cd	email	user.attribute
d8aebd7b-be98-4994-bafe-8f68dc58e2cd	true	id.token.claim
d8aebd7b-be98-4994-bafe-8f68dc58e2cd	true	access.token.claim
d8aebd7b-be98-4994-bafe-8f68dc58e2cd	email	claim.name
d8aebd7b-be98-4994-bafe-8f68dc58e2cd	String	jsonType.label
683f9b16-ab60-422b-b1d8-8c64ae81a0b7	true	userinfo.token.claim
683f9b16-ab60-422b-b1d8-8c64ae81a0b7	emailVerified	user.attribute
683f9b16-ab60-422b-b1d8-8c64ae81a0b7	true	id.token.claim
683f9b16-ab60-422b-b1d8-8c64ae81a0b7	true	access.token.claim
683f9b16-ab60-422b-b1d8-8c64ae81a0b7	email_verified	claim.name
683f9b16-ab60-422b-b1d8-8c64ae81a0b7	boolean	jsonType.label
e8c13c08-5be8-429c-ae49-fc3a97c696a4	formatted	user.attribute.formatted
e8c13c08-5be8-429c-ae49-fc3a97c696a4	country	user.attribute.country
e8c13c08-5be8-429c-ae49-fc3a97c696a4	postal_code	user.attribute.postal_code
e8c13c08-5be8-429c-ae49-fc3a97c696a4	true	userinfo.token.claim
e8c13c08-5be8-429c-ae49-fc3a97c696a4	street	user.attribute.street
e8c13c08-5be8-429c-ae49-fc3a97c696a4	true	id.token.claim
e8c13c08-5be8-429c-ae49-fc3a97c696a4	region	user.attribute.region
e8c13c08-5be8-429c-ae49-fc3a97c696a4	true	access.token.claim
e8c13c08-5be8-429c-ae49-fc3a97c696a4	locality	user.attribute.locality
d6ec1d5c-3f9c-428e-9b8a-6dde0a95051c	true	userinfo.token.claim
d6ec1d5c-3f9c-428e-9b8a-6dde0a95051c	phoneNumber	user.attribute
d6ec1d5c-3f9c-428e-9b8a-6dde0a95051c	true	id.token.claim
d6ec1d5c-3f9c-428e-9b8a-6dde0a95051c	true	access.token.claim
d6ec1d5c-3f9c-428e-9b8a-6dde0a95051c	phone_number	claim.name
d6ec1d5c-3f9c-428e-9b8a-6dde0a95051c	String	jsonType.label
d835a6c4-4835-46f4-b9be-f7e252473a4f	true	userinfo.token.claim
d835a6c4-4835-46f4-b9be-f7e252473a4f	phoneNumberVerified	user.attribute
d835a6c4-4835-46f4-b9be-f7e252473a4f	true	id.token.claim
d835a6c4-4835-46f4-b9be-f7e252473a4f	true	access.token.claim
d835a6c4-4835-46f4-b9be-f7e252473a4f	phone_number_verified	claim.name
d835a6c4-4835-46f4-b9be-f7e252473a4f	boolean	jsonType.label
02fd33b9-d956-44e5-a2f2-ed8196bf75ac	true	multivalued
02fd33b9-d956-44e5-a2f2-ed8196bf75ac	foo	user.attribute
02fd33b9-d956-44e5-a2f2-ed8196bf75ac	true	access.token.claim
02fd33b9-d956-44e5-a2f2-ed8196bf75ac	realm_access.roles	claim.name
02fd33b9-d956-44e5-a2f2-ed8196bf75ac	String	jsonType.label
ecc39105-1128-4b9f-8669-1b583fe5c95c	true	multivalued
ecc39105-1128-4b9f-8669-1b583fe5c95c	foo	user.attribute
ecc39105-1128-4b9f-8669-1b583fe5c95c	true	access.token.claim
ecc39105-1128-4b9f-8669-1b583fe5c95c	resource_access.${client_id}.roles	claim.name
ecc39105-1128-4b9f-8669-1b583fe5c95c	String	jsonType.label
100cf8dd-1037-4fb6-9394-a6857dcb962f	true	userinfo.token.claim
100cf8dd-1037-4fb6-9394-a6857dcb962f	username	user.attribute
100cf8dd-1037-4fb6-9394-a6857dcb962f	true	id.token.claim
100cf8dd-1037-4fb6-9394-a6857dcb962f	true	access.token.claim
100cf8dd-1037-4fb6-9394-a6857dcb962f	upn	claim.name
100cf8dd-1037-4fb6-9394-a6857dcb962f	String	jsonType.label
0f943d79-eb2b-47d2-a7e1-3dca18f9dfc9	true	multivalued
0f943d79-eb2b-47d2-a7e1-3dca18f9dfc9	foo	user.attribute
0f943d79-eb2b-47d2-a7e1-3dca18f9dfc9	true	id.token.claim
0f943d79-eb2b-47d2-a7e1-3dca18f9dfc9	true	access.token.claim
0f943d79-eb2b-47d2-a7e1-3dca18f9dfc9	groups	claim.name
0f943d79-eb2b-47d2-a7e1-3dca18f9dfc9	String	jsonType.label
501bd85e-911b-4ab1-8a88-27c47c3df2f8	false	single
501bd85e-911b-4ab1-8a88-27c47c3df2f8	Basic	attribute.nameformat
501bd85e-911b-4ab1-8a88-27c47c3df2f8	Role	attribute.name
d452527f-ad84-4749-a463-50956f0711b1	true	userinfo.token.claim
d452527f-ad84-4749-a463-50956f0711b1	true	id.token.claim
d452527f-ad84-4749-a463-50956f0711b1	true	access.token.claim
a847ed3f-fe20-45b5-96f7-85a19e4e9922	true	userinfo.token.claim
a847ed3f-fe20-45b5-96f7-85a19e4e9922	lastName	user.attribute
a847ed3f-fe20-45b5-96f7-85a19e4e9922	true	id.token.claim
a847ed3f-fe20-45b5-96f7-85a19e4e9922	true	access.token.claim
a847ed3f-fe20-45b5-96f7-85a19e4e9922	family_name	claim.name
a847ed3f-fe20-45b5-96f7-85a19e4e9922	String	jsonType.label
2aba8c18-4405-4270-850f-2d97b934ea33	true	userinfo.token.claim
2aba8c18-4405-4270-850f-2d97b934ea33	firstName	user.attribute
2aba8c18-4405-4270-850f-2d97b934ea33	true	id.token.claim
2aba8c18-4405-4270-850f-2d97b934ea33	true	access.token.claim
2aba8c18-4405-4270-850f-2d97b934ea33	given_name	claim.name
2aba8c18-4405-4270-850f-2d97b934ea33	String	jsonType.label
a822cddc-23cb-4660-b445-58366c03bbab	true	userinfo.token.claim
a822cddc-23cb-4660-b445-58366c03bbab	middleName	user.attribute
a822cddc-23cb-4660-b445-58366c03bbab	true	id.token.claim
a822cddc-23cb-4660-b445-58366c03bbab	true	access.token.claim
a822cddc-23cb-4660-b445-58366c03bbab	middle_name	claim.name
a822cddc-23cb-4660-b445-58366c03bbab	String	jsonType.label
9e4cb13d-59f5-4ed7-916c-8089750828b6	true	userinfo.token.claim
9e4cb13d-59f5-4ed7-916c-8089750828b6	nickname	user.attribute
9e4cb13d-59f5-4ed7-916c-8089750828b6	true	id.token.claim
9e4cb13d-59f5-4ed7-916c-8089750828b6	true	access.token.claim
9e4cb13d-59f5-4ed7-916c-8089750828b6	nickname	claim.name
9e4cb13d-59f5-4ed7-916c-8089750828b6	String	jsonType.label
cb27e260-f34c-4c2f-bbca-0da14fda109b	true	userinfo.token.claim
cb27e260-f34c-4c2f-bbca-0da14fda109b	username	user.attribute
cb27e260-f34c-4c2f-bbca-0da14fda109b	true	id.token.claim
cb27e260-f34c-4c2f-bbca-0da14fda109b	true	access.token.claim
cb27e260-f34c-4c2f-bbca-0da14fda109b	preferred_username	claim.name
cb27e260-f34c-4c2f-bbca-0da14fda109b	String	jsonType.label
53bd1bd8-25df-482f-baba-e6843e91c2c6	true	userinfo.token.claim
53bd1bd8-25df-482f-baba-e6843e91c2c6	profile	user.attribute
53bd1bd8-25df-482f-baba-e6843e91c2c6	true	id.token.claim
53bd1bd8-25df-482f-baba-e6843e91c2c6	true	access.token.claim
53bd1bd8-25df-482f-baba-e6843e91c2c6	profile	claim.name
53bd1bd8-25df-482f-baba-e6843e91c2c6	String	jsonType.label
dd78b304-2313-41ad-bc02-0644eb7e11f8	true	userinfo.token.claim
dd78b304-2313-41ad-bc02-0644eb7e11f8	picture	user.attribute
dd78b304-2313-41ad-bc02-0644eb7e11f8	true	id.token.claim
dd78b304-2313-41ad-bc02-0644eb7e11f8	true	access.token.claim
dd78b304-2313-41ad-bc02-0644eb7e11f8	picture	claim.name
dd78b304-2313-41ad-bc02-0644eb7e11f8	String	jsonType.label
602a8772-dc37-432a-bc8a-0183de719111	true	userinfo.token.claim
602a8772-dc37-432a-bc8a-0183de719111	website	user.attribute
602a8772-dc37-432a-bc8a-0183de719111	true	id.token.claim
602a8772-dc37-432a-bc8a-0183de719111	true	access.token.claim
602a8772-dc37-432a-bc8a-0183de719111	website	claim.name
602a8772-dc37-432a-bc8a-0183de719111	String	jsonType.label
2b7ad4e4-6c5c-4189-b44d-aef1b504680f	true	userinfo.token.claim
2b7ad4e4-6c5c-4189-b44d-aef1b504680f	gender	user.attribute
2b7ad4e4-6c5c-4189-b44d-aef1b504680f	true	id.token.claim
2b7ad4e4-6c5c-4189-b44d-aef1b504680f	true	access.token.claim
2b7ad4e4-6c5c-4189-b44d-aef1b504680f	gender	claim.name
2b7ad4e4-6c5c-4189-b44d-aef1b504680f	String	jsonType.label
b0851f64-ccab-48c0-a097-6ea7406cf780	true	userinfo.token.claim
b0851f64-ccab-48c0-a097-6ea7406cf780	birthdate	user.attribute
b0851f64-ccab-48c0-a097-6ea7406cf780	true	id.token.claim
b0851f64-ccab-48c0-a097-6ea7406cf780	true	access.token.claim
b0851f64-ccab-48c0-a097-6ea7406cf780	birthdate	claim.name
b0851f64-ccab-48c0-a097-6ea7406cf780	String	jsonType.label
72d27071-40d0-4b03-a312-3a547bf3e8c0	true	userinfo.token.claim
72d27071-40d0-4b03-a312-3a547bf3e8c0	zoneinfo	user.attribute
72d27071-40d0-4b03-a312-3a547bf3e8c0	true	id.token.claim
72d27071-40d0-4b03-a312-3a547bf3e8c0	true	access.token.claim
72d27071-40d0-4b03-a312-3a547bf3e8c0	zoneinfo	claim.name
72d27071-40d0-4b03-a312-3a547bf3e8c0	String	jsonType.label
17cd328f-1c60-4af2-9b23-ee9708a26083	true	userinfo.token.claim
17cd328f-1c60-4af2-9b23-ee9708a26083	locale	user.attribute
17cd328f-1c60-4af2-9b23-ee9708a26083	true	id.token.claim
17cd328f-1c60-4af2-9b23-ee9708a26083	true	access.token.claim
17cd328f-1c60-4af2-9b23-ee9708a26083	locale	claim.name
17cd328f-1c60-4af2-9b23-ee9708a26083	String	jsonType.label
4645296f-45e8-49d8-992f-8b1853d41729	true	userinfo.token.claim
4645296f-45e8-49d8-992f-8b1853d41729	updatedAt	user.attribute
4645296f-45e8-49d8-992f-8b1853d41729	true	id.token.claim
4645296f-45e8-49d8-992f-8b1853d41729	true	access.token.claim
4645296f-45e8-49d8-992f-8b1853d41729	updated_at	claim.name
4645296f-45e8-49d8-992f-8b1853d41729	String	jsonType.label
c2100c1d-4315-4215-a6f3-779563687781	true	userinfo.token.claim
c2100c1d-4315-4215-a6f3-779563687781	email	user.attribute
c2100c1d-4315-4215-a6f3-779563687781	true	id.token.claim
c2100c1d-4315-4215-a6f3-779563687781	true	access.token.claim
c2100c1d-4315-4215-a6f3-779563687781	email	claim.name
c2100c1d-4315-4215-a6f3-779563687781	String	jsonType.label
9fe4b022-da93-4404-b530-043c0eb89c91	true	userinfo.token.claim
9fe4b022-da93-4404-b530-043c0eb89c91	emailVerified	user.attribute
9fe4b022-da93-4404-b530-043c0eb89c91	true	id.token.claim
9fe4b022-da93-4404-b530-043c0eb89c91	true	access.token.claim
9fe4b022-da93-4404-b530-043c0eb89c91	email_verified	claim.name
9fe4b022-da93-4404-b530-043c0eb89c91	boolean	jsonType.label
ec8e385a-efad-4577-9e80-7ba19484cf05	formatted	user.attribute.formatted
ec8e385a-efad-4577-9e80-7ba19484cf05	country	user.attribute.country
ec8e385a-efad-4577-9e80-7ba19484cf05	postal_code	user.attribute.postal_code
ec8e385a-efad-4577-9e80-7ba19484cf05	true	userinfo.token.claim
ec8e385a-efad-4577-9e80-7ba19484cf05	street	user.attribute.street
ec8e385a-efad-4577-9e80-7ba19484cf05	true	id.token.claim
ec8e385a-efad-4577-9e80-7ba19484cf05	region	user.attribute.region
ec8e385a-efad-4577-9e80-7ba19484cf05	true	access.token.claim
ec8e385a-efad-4577-9e80-7ba19484cf05	locality	user.attribute.locality
9ee19065-bc47-44c4-a2c2-7c6894297ab5	true	userinfo.token.claim
9ee19065-bc47-44c4-a2c2-7c6894297ab5	phoneNumber	user.attribute
9ee19065-bc47-44c4-a2c2-7c6894297ab5	true	id.token.claim
9ee19065-bc47-44c4-a2c2-7c6894297ab5	true	access.token.claim
9ee19065-bc47-44c4-a2c2-7c6894297ab5	phone_number	claim.name
9ee19065-bc47-44c4-a2c2-7c6894297ab5	String	jsonType.label
a0d08760-0f24-478d-a1ff-9d067c25598a	true	userinfo.token.claim
a0d08760-0f24-478d-a1ff-9d067c25598a	phoneNumberVerified	user.attribute
a0d08760-0f24-478d-a1ff-9d067c25598a	true	id.token.claim
a0d08760-0f24-478d-a1ff-9d067c25598a	true	access.token.claim
a0d08760-0f24-478d-a1ff-9d067c25598a	phone_number_verified	claim.name
a0d08760-0f24-478d-a1ff-9d067c25598a	boolean	jsonType.label
120e1b1e-780a-42dd-b636-5ba182ed6c8e	true	multivalued
120e1b1e-780a-42dd-b636-5ba182ed6c8e	foo	user.attribute
120e1b1e-780a-42dd-b636-5ba182ed6c8e	true	access.token.claim
120e1b1e-780a-42dd-b636-5ba182ed6c8e	realm_access.roles	claim.name
120e1b1e-780a-42dd-b636-5ba182ed6c8e	String	jsonType.label
c48e9b4a-7722-47a3-81ab-d6eeb6786aba	true	multivalued
c48e9b4a-7722-47a3-81ab-d6eeb6786aba	foo	user.attribute
c48e9b4a-7722-47a3-81ab-d6eeb6786aba	true	access.token.claim
c48e9b4a-7722-47a3-81ab-d6eeb6786aba	resource_access.${client_id}.roles	claim.name
c48e9b4a-7722-47a3-81ab-d6eeb6786aba	String	jsonType.label
dc5dced8-923d-4be2-a6e0-b5b1d3dd5755	true	userinfo.token.claim
dc5dced8-923d-4be2-a6e0-b5b1d3dd5755	username	user.attribute
dc5dced8-923d-4be2-a6e0-b5b1d3dd5755	true	id.token.claim
dc5dced8-923d-4be2-a6e0-b5b1d3dd5755	true	access.token.claim
dc5dced8-923d-4be2-a6e0-b5b1d3dd5755	upn	claim.name
dc5dced8-923d-4be2-a6e0-b5b1d3dd5755	String	jsonType.label
3ce96f0b-4da0-40c6-947a-216bfae59ff3	true	multivalued
3ce96f0b-4da0-40c6-947a-216bfae59ff3	foo	user.attribute
3ce96f0b-4da0-40c6-947a-216bfae59ff3	true	id.token.claim
3ce96f0b-4da0-40c6-947a-216bfae59ff3	true	access.token.claim
3ce96f0b-4da0-40c6-947a-216bfae59ff3	groups	claim.name
3ce96f0b-4da0-40c6-947a-216bfae59ff3	String	jsonType.label
771a0d2e-4731-4b8a-b773-3394d6e23579	true	userinfo.token.claim
771a0d2e-4731-4b8a-b773-3394d6e23579	locale	user.attribute
771a0d2e-4731-4b8a-b773-3394d6e23579	true	id.token.claim
771a0d2e-4731-4b8a-b773-3394d6e23579	true	access.token.claim
771a0d2e-4731-4b8a-b773-3394d6e23579	locale	claim.name
771a0d2e-4731-4b8a-b773-3394d6e23579	String	jsonType.label
d0c1824a-551f-4d7f-ac7d-c2ad29ed73ab	clientId	user.session.note
d0c1824a-551f-4d7f-ac7d-c2ad29ed73ab	true	id.token.claim
d0c1824a-551f-4d7f-ac7d-c2ad29ed73ab	true	access.token.claim
d0c1824a-551f-4d7f-ac7d-c2ad29ed73ab	clientId	claim.name
d0c1824a-551f-4d7f-ac7d-c2ad29ed73ab	String	jsonType.label
47498844-756e-4bd5-90eb-9ce1bdb92476	clientHost	user.session.note
47498844-756e-4bd5-90eb-9ce1bdb92476	true	id.token.claim
47498844-756e-4bd5-90eb-9ce1bdb92476	true	access.token.claim
47498844-756e-4bd5-90eb-9ce1bdb92476	clientHost	claim.name
47498844-756e-4bd5-90eb-9ce1bdb92476	String	jsonType.label
58ea770f-b0b0-4cc8-a71f-d0ee0eeccb12	clientAddress	user.session.note
58ea770f-b0b0-4cc8-a71f-d0ee0eeccb12	true	id.token.claim
58ea770f-b0b0-4cc8-a71f-d0ee0eeccb12	true	access.token.claim
58ea770f-b0b0-4cc8-a71f-d0ee0eeccb12	clientAddress	claim.name
58ea770f-b0b0-4cc8-a71f-d0ee0eeccb12	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
test	60	300	300	\N	\N	\N	t	f	0	\N	test	0	\N	t	f	t	f	EXTERNAL	1800	36000	f	t	8da5b847-e08a-4416-b7bb-19da50324f32	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f2a839f8-17ed-4219-8c9a-9e385937c090	73e1871d-1ffe-42a0-b58c-487743391f8b	54500e67-cee1-43cd-9777-b1728d60ec13	f689c3f9-5c53-47b5-86ff-51e1638e5c4f	6f625bbe-585e-4f87-aaaa-85dd04d4bca6	2592000	f	900	t	f	32514373-4fc7-4061-9801-1198de02e16e	0	f	0	0
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	abc7f818-4fd6-4b54-a3c6-48b18c789c00	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	aed1f280-a5a5-4922-af01-2d7041010485	71136b74-b058-46b3-9687-d4c835ca0ea2	bbaa95ea-6115-4b1c-88ea-2e7f883a9652	b27e2186-2702-443e-b0d9-e6c3aecfbfe8	c277a1d3-177d-4dcc-999d-4b70b0cfd640	2592000	f	900	t	f	581ca990-30e8-4601-ae74-9e01f21ab5d0	0	f	0	0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
_browser_header.contentSecurityPolicyReportOnly		test
_browser_header.xContentTypeOptions	nosniff	test
_browser_header.xRobotsTag	none	test
_browser_header.xFrameOptions	SAMEORIGIN	test
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	test
_browser_header.xXSSProtection	1; mode=block	test
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	test
bruteForceProtected	false	test
permanentLockout	false	test
maxFailureWaitSeconds	900	test
minimumQuickLoginWaitSeconds	60	test
waitIncrementSeconds	60	test
quickLoginCheckMilliSeconds	1000	test
maxDeltaTimeSeconds	43200	test
failureFactor	30	test
offlineSessionMaxLifespanEnabled	false	test
offlineSessionMaxLifespan	5184000	test
actionTokenGeneratedByAdminLifespan	43200	test
actionTokenGeneratedByUserLifespan	300	test
webAuthnPolicyRpEntityName	keycloak	test
webAuthnPolicySignatureAlgorithms	ES256	test
webAuthnPolicyRpId		test
webAuthnPolicyAttestationConveyancePreference	not specified	test
webAuthnPolicyAuthenticatorAttachment	not specified	test
webAuthnPolicyRequireResidentKey	not specified	test
webAuthnPolicyUserVerificationRequirement	not specified	test
webAuthnPolicyCreateTimeout	0	test
webAuthnPolicyAvoidSameAuthenticatorRegister	false	test
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	c93975fb-d01d-46de-ba8a-3cf949e09db1
master	aded55b8-84b5-469d-bfa7-ae7d29bedf8b
test	d5eb4e92-88e2-4bfc-b11a-e3a338d12953
test	5450836e-a708-41d5-ac90-90817402c19b
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
test	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	test
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
ea3b6386-3a19-4970-8b4e-be48fe310294	/realms/master/account/*
211b769c-3db2-420a-93a3-aee2d24990b1	/admin/master/console/*
d92ffcff-af21-4144-b731-a89bd59cdf5e	/realms/test/account/*
810c10be-2cca-472b-9785-23a7e2668a9c	/admin/test/console/*
e62df68a-4189-4aaa-b5cd-09909251c2a3	/
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	http://localhost:8000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
b2e09ea2-ef9e-46a6-b2dc-fe4c2e2e6cf8	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
17284808-25a8-43b9-9edc-295f7d7d1d6c	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
e785bf19-2cae-4c26-9528-1f8b11ada8b2	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
f2cc515b-9043-440f-941f-14be131ff9ef	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
fb689553-1cef-4ec3-b730-415cabeebc8e	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
87bf8517-613a-4d4f-80bc-89c5ef52d996	VERIFY_EMAIL	Verify Email	test	t	f	VERIFY_EMAIL	50
c4ccc6ff-7652-4418-8187-f356cdd40396	UPDATE_PROFILE	Update Profile	test	t	f	UPDATE_PROFILE	40
26829cf9-50e0-4dfc-a6c5-ef784692bfce	CONFIGURE_TOTP	Configure OTP	test	t	f	CONFIGURE_TOTP	10
f42940a0-9a4f-42da-a796-80a3e9341373	UPDATE_PASSWORD	Update Password	test	t	f	UPDATE_PASSWORD	30
7538b68c-af37-4a7b-b0cc-ad669ad302ea	terms_and_conditions	Terms and Conditions	test	f	f	terms_and_conditions	20
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
df81f3cf-7ab2-4ccc-81ad-629e1bd18607	Default Policy	A policy that grants access only for users within this realm	js	0	0	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	\N
1bbf642d-6b3c-43af-9790-1608634881c7	Default Permission	A permission that applies to the default resource type	resource	1	0	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
5569a91f-3f66-4586-a5a9-8acf1fda2ebc	Default Resource	urn:kong:resources:default	\N	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
5569a91f-3f66-4586-a5a9-8acf1fda2ebc	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
86d125d1-da32-41af-b792-1c1fa4693efc	\N	15d9f3e0-c0e1-4efa-a860-85ef52730f9b	f	t	\N	\N	\N	master	admin	1585055547117	\N	0
58b0d88b-7e7b-4da5-9ea8-f81425f54bf6	\N	ff439682-ea96-4e72-95ea-bec07d2cf79c	f	t	\N	\N	\N	test	service-account-kong	1586881778836	f62fc94f-75b0-4bba-82e0-425f3bb0ea89	0
6418686e-f9e2-424d-b7c1-481bca508500	\N	1bd1f94b-bc7d-4d54-b0ab-75aa40839f1d	t	t	\N	\N	\N	test	admin	1586885972762	\N	0
78c5cfa9-3e79-4079-9fe7-5ef3eeb0ce5b	demouser@gmail.com	demouser@gmail.com	t	t	\N	\N	\N	test	demouser	1585057596544	\N	1588697083
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
c93975fb-d01d-46de-ba8a-3cf949e09db1	86d125d1-da32-41af-b792-1c1fa4693efc
b3337f6f-5016-49cd-912b-517f30e5bc07	86d125d1-da32-41af-b792-1c1fa4693efc
917ce590-59c7-4a05-b488-7735cae4452d	86d125d1-da32-41af-b792-1c1fa4693efc
aded55b8-84b5-469d-bfa7-ae7d29bedf8b	86d125d1-da32-41af-b792-1c1fa4693efc
6920b008-f214-4ba2-a06a-fed8b0539bdc	86d125d1-da32-41af-b792-1c1fa4693efc
d5eb4e92-88e2-4bfc-b11a-e3a338d12953	78c5cfa9-3e79-4079-9fe7-5ef3eeb0ce5b
82fbe66e-a7b7-44ec-ae66-72746eb06f04	78c5cfa9-3e79-4079-9fe7-5ef3eeb0ce5b
5450836e-a708-41d5-ac90-90817402c19b	78c5cfa9-3e79-4079-9fe7-5ef3eeb0ce5b
c1fa9ff0-acb6-4c1e-b4a5-2b6ed40138f5	78c5cfa9-3e79-4079-9fe7-5ef3eeb0ce5b
d5eb4e92-88e2-4bfc-b11a-e3a338d12953	58b0d88b-7e7b-4da5-9ea8-f81425f54bf6
82fbe66e-a7b7-44ec-ae66-72746eb06f04	58b0d88b-7e7b-4da5-9ea8-f81425f54bf6
5450836e-a708-41d5-ac90-90817402c19b	58b0d88b-7e7b-4da5-9ea8-f81425f54bf6
c1fa9ff0-acb6-4c1e-b4a5-2b6ed40138f5	58b0d88b-7e7b-4da5-9ea8-f81425f54bf6
ae8689e0-b63d-4c5e-94bb-0afe941fa629	58b0d88b-7e7b-4da5-9ea8-f81425f54bf6
d5eb4e92-88e2-4bfc-b11a-e3a338d12953	6418686e-f9e2-424d-b7c1-481bca508500
82fbe66e-a7b7-44ec-ae66-72746eb06f04	6418686e-f9e2-424d-b7c1-481bca508500
5450836e-a708-41d5-ac90-90817402c19b	6418686e-f9e2-424d-b7c1-481bca508500
c1fa9ff0-acb6-4c1e-b4a5-2b6ed40138f5	6418686e-f9e2-424d-b7c1-481bca508500
97c0dcb1-3f6c-4d7e-8712-dbfc0ac36f3e	6418686e-f9e2-424d-b7c1-481bca508500
265fa242-a1b7-4eb8-99b7-31ca8f9f76d8	6418686e-f9e2-424d-b7c1-481bca508500
291dd9db-a1dd-4f21-b48d-6d9d8b8e0aa7	6418686e-f9e2-424d-b7c1-481bca508500
8414547b-b9ad-43a6-af3d-66e826753a92	6418686e-f9e2-424d-b7c1-481bca508500
57afecd0-6a1e-42db-a7f6-222605d16732	6418686e-f9e2-424d-b7c1-481bca508500
1f06229c-807c-4689-82d0-ffc1c69727a3	6418686e-f9e2-424d-b7c1-481bca508500
dd223aa5-8072-4415-9387-9ded8c0245e5	6418686e-f9e2-424d-b7c1-481bca508500
4fff674d-36c5-49da-a80f-2b7832332c2d	6418686e-f9e2-424d-b7c1-481bca508500
84c5de6b-ac36-4f78-8d40-04e4cb7d1af9	6418686e-f9e2-424d-b7c1-481bca508500
1c003bb4-47a9-42aa-8c49-e3d94f6e4f9e	6418686e-f9e2-424d-b7c1-481bca508500
58f0b72c-d6f5-4a9f-a2b9-c7a1701878d3	6418686e-f9e2-424d-b7c1-481bca508500
afce20ee-0d6e-4433-bb67-9f59a9e0bb05	6418686e-f9e2-424d-b7c1-481bca508500
28c61854-e356-48de-92cd-d52ce71685c7	6418686e-f9e2-424d-b7c1-481bca508500
25a3c840-57bd-4a4a-a45b-bdb6163c4f02	58b0d88b-7e7b-4da5-9ea8-f81425f54bf6
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
211b769c-3db2-420a-93a3-aee2d24990b1	+
810c10be-2cca-472b-9785-23a7e2668a9c	+
f62fc94f-75b0-4bba-82e0-425f3bb0ea89	http://localhost:8000/users/login
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


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
-- Name: postgres; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO keycloak;

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: keycloak
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

