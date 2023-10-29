--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Debian 14.8-1.pgdg120+1)
-- Dumped by pg_dump version 14.8 (Debian 14.8-1.pgdg120+1)

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
-- Name: assign_unleash_permission_to_role(text, text); Type: FUNCTION; Schema: public; Owner: smarttesting
--

CREATE FUNCTION public.assign_unleash_permission_to_role(permission_name text, role_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
    declare role_id int;
            permission_id int;
BEGIN
    role_id := (SELECT id FROM roles WHERE name = role_name);
    permission_id := (SELECT p.id FROM permissions p WHERE p.permission = permission_name);
    INSERT INTO role_permission(role_id, permission_id) VALUES (role_id, permission_id);
END
$$;


ALTER FUNCTION public.assign_unleash_permission_to_role(permission_name text, role_name text) OWNER TO smarttesting;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addons; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.addons (
    id integer NOT NULL,
    provider text NOT NULL,
    description text,
    enabled boolean DEFAULT true,
    parameters json,
    events json,
    created_at timestamp with time zone DEFAULT now(),
    projects jsonb DEFAULT '[]'::jsonb,
    environments jsonb DEFAULT '[]'::jsonb
);


ALTER TABLE public.addons OWNER TO smarttesting;

--
-- Name: addons_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.addons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addons_id_seq OWNER TO smarttesting;

--
-- Name: addons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.addons_id_seq OWNED BY public.addons.id;


--
-- Name: api_token_project; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.api_token_project (
    secret text NOT NULL,
    project text NOT NULL
);


ALTER TABLE public.api_token_project OWNER TO smarttesting;

--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.api_tokens (
    secret text NOT NULL,
    username text NOT NULL,
    type text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    expires_at timestamp with time zone,
    seen_at timestamp with time zone,
    environment character varying,
    alias text,
    token_name text
);


ALTER TABLE public.api_tokens OWNER TO smarttesting;

--
-- Name: change_request_approvals; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.change_request_approvals (
    id integer NOT NULL,
    change_request_id integer NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.change_request_approvals OWNER TO smarttesting;

--
-- Name: change_request_approvals_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.change_request_approvals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_request_approvals_id_seq OWNER TO smarttesting;

--
-- Name: change_request_approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.change_request_approvals_id_seq OWNED BY public.change_request_approvals.id;


--
-- Name: change_request_comments; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.change_request_comments (
    id integer NOT NULL,
    change_request integer NOT NULL,
    text text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    created_by integer NOT NULL
);


ALTER TABLE public.change_request_comments OWNER TO smarttesting;

--
-- Name: change_request_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.change_request_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_request_comments_id_seq OWNER TO smarttesting;

--
-- Name: change_request_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.change_request_comments_id_seq OWNED BY public.change_request_comments.id;


--
-- Name: change_request_events; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.change_request_events (
    id integer NOT NULL,
    feature character varying(255),
    action character varying(255) NOT NULL,
    payload jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    change_request_id integer NOT NULL
);


ALTER TABLE public.change_request_events OWNER TO smarttesting;

--
-- Name: change_request_events_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.change_request_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_request_events_id_seq OWNER TO smarttesting;

--
-- Name: change_request_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.change_request_events_id_seq OWNED BY public.change_request_events.id;


--
-- Name: change_request_rejections; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.change_request_rejections (
    id integer NOT NULL,
    change_request_id integer NOT NULL,
    created_by integer NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.change_request_rejections OWNER TO smarttesting;

--
-- Name: change_request_rejections_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.change_request_rejections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_request_rejections_id_seq OWNER TO smarttesting;

--
-- Name: change_request_rejections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.change_request_rejections_id_seq OWNED BY public.change_request_rejections.id;


--
-- Name: change_request_settings; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.change_request_settings (
    project character varying(255) NOT NULL,
    environment character varying(100) NOT NULL,
    required_approvals integer DEFAULT 1
);


ALTER TABLE public.change_request_settings OWNER TO smarttesting;

--
-- Name: change_requests; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.change_requests (
    id integer NOT NULL,
    environment character varying(100),
    state character varying(255) NOT NULL,
    project character varying(255),
    created_by integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    min_approvals integer DEFAULT 1,
    title text
);


ALTER TABLE public.change_requests OWNER TO smarttesting;

--
-- Name: change_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.change_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_requests_id_seq OWNER TO smarttesting;

--
-- Name: change_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.change_requests_id_seq OWNED BY public.change_requests.id;


--
-- Name: client_applications; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.client_applications (
    app_name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    seen_at timestamp with time zone,
    strategies json,
    description character varying(255),
    icon character varying(255),
    url character varying(255),
    color character varying(255),
    announced boolean DEFAULT false,
    created_by text
);


ALTER TABLE public.client_applications OWNER TO smarttesting;

--
-- Name: client_applications_usage; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.client_applications_usage (
    app_name character varying(255) NOT NULL,
    project character varying(255) NOT NULL,
    environment character varying(100) NOT NULL
);


ALTER TABLE public.client_applications_usage OWNER TO smarttesting;

--
-- Name: client_instances; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.client_instances (
    app_name character varying(255) NOT NULL,
    instance_id character varying(255) NOT NULL,
    client_ip character varying(255),
    last_seen timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now(),
    sdk_version character varying(255),
    environment character varying(255) DEFAULT 'default'::character varying NOT NULL
);


ALTER TABLE public.client_instances OWNER TO smarttesting;

--
-- Name: client_metrics_env; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.client_metrics_env (
    feature_name character varying(255) NOT NULL,
    app_name character varying(255) NOT NULL,
    environment character varying(100) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    yes bigint DEFAULT 0,
    no bigint DEFAULT 0
);


ALTER TABLE public.client_metrics_env OWNER TO smarttesting;

--
-- Name: client_metrics_env_variants; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.client_metrics_env_variants (
    feature_name character varying(255) NOT NULL,
    app_name character varying(255) NOT NULL,
    environment character varying(100) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    variant text NOT NULL,
    count integer DEFAULT 0
);


ALTER TABLE public.client_metrics_env_variants OWNER TO smarttesting;

--
-- Name: context_fields; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.context_fields (
    name character varying(255) NOT NULL,
    description text,
    sort_order integer DEFAULT 10,
    legal_values json,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    stickiness boolean DEFAULT false
);


ALTER TABLE public.context_fields OWNER TO smarttesting;

--
-- Name: environments; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.environments (
    name character varying(100) NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    sort_order integer DEFAULT 9999,
    type text NOT NULL,
    enabled boolean DEFAULT true,
    protected boolean DEFAULT false
);


ALTER TABLE public.environments OWNER TO smarttesting;

--
-- Name: events; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.events (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    type character varying(255) NOT NULL,
    created_by character varying(255) NOT NULL,
    data json,
    tags json DEFAULT '[]'::json,
    project text,
    environment text,
    feature_name text,
    pre_data jsonb,
    announced boolean DEFAULT false
);


ALTER TABLE public.events OWNER TO smarttesting;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO smarttesting;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: favorite_features; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.favorite_features (
    feature character varying(255) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.favorite_features OWNER TO smarttesting;

--
-- Name: favorite_projects; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.favorite_projects (
    project character varying(255) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.favorite_projects OWNER TO smarttesting;

--
-- Name: feature_environments; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.feature_environments (
    environment character varying(100) DEFAULT 'default'::character varying NOT NULL,
    feature_name character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    variants jsonb DEFAULT '[]'::jsonb NOT NULL,
    last_seen_at timestamp with time zone
);


ALTER TABLE public.feature_environments OWNER TO smarttesting;

--
-- Name: feature_strategies; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.feature_strategies (
    id text NOT NULL,
    feature_name character varying(255) NOT NULL,
    project_name character varying(255) NOT NULL,
    environment character varying(100) DEFAULT 'default'::character varying NOT NULL,
    strategy_name character varying(255) NOT NULL,
    parameters jsonb DEFAULT '{}'::jsonb NOT NULL,
    constraints jsonb,
    sort_order integer DEFAULT 9999 NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    title text,
    disabled boolean DEFAULT false,
    variants jsonb DEFAULT '[]'::jsonb NOT NULL
);


ALTER TABLE public.feature_strategies OWNER TO smarttesting;

--
-- Name: feature_strategy_segment; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.feature_strategy_segment (
    feature_strategy_id text NOT NULL,
    segment_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.feature_strategy_segment OWNER TO smarttesting;

--
-- Name: feature_tag; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.feature_tag (
    feature_name character varying(255) NOT NULL,
    tag_type text NOT NULL,
    tag_value text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.feature_tag OWNER TO smarttesting;

--
-- Name: feature_types; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.feature_types (
    id character varying(255) NOT NULL,
    name character varying NOT NULL,
    description character varying,
    lifetime_days integer,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.feature_types OWNER TO smarttesting;

--
-- Name: features; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.features (
    created_at timestamp with time zone DEFAULT now(),
    name character varying(255) NOT NULL,
    description text,
    archived boolean DEFAULT false,
    variants json DEFAULT '[]'::json,
    type character varying DEFAULT 'release'::character varying,
    stale boolean DEFAULT false,
    project character varying DEFAULT 'default'::character varying,
    last_seen_at timestamp with time zone,
    impression_data boolean DEFAULT false,
    archived_at timestamp with time zone,
    potentially_stale boolean
);


ALTER TABLE public.features OWNER TO smarttesting;

--
-- Name: features_view; Type: VIEW; Schema: public; Owner: smarttesting
--

CREATE VIEW public.features_view AS
 SELECT features.name,
    features.description,
    features.type,
    features.project,
    features.stale,
    features.impression_data,
    features.created_at,
    features.archived_at,
    features.last_seen_at,
    feature_environments.last_seen_at AS env_last_seen_at,
    feature_environments.enabled,
    feature_environments.environment,
    feature_environments.variants,
    environments.name AS environment_name,
    environments.type AS environment_type,
    environments.sort_order AS environment_sort_order,
    feature_strategies.id AS strategy_id,
    feature_strategies.strategy_name,
    feature_strategies.parameters,
    feature_strategies.constraints,
    feature_strategies.sort_order,
    fss.segment_id AS segments,
    feature_strategies.title AS strategy_title,
    feature_strategies.disabled AS strategy_disabled,
    feature_strategies.variants AS strategy_variants
   FROM ((((public.features
     LEFT JOIN public.feature_environments ON (((feature_environments.feature_name)::text = (features.name)::text)))
     LEFT JOIN public.feature_strategies ON ((((feature_strategies.feature_name)::text = (feature_environments.feature_name)::text) AND ((feature_strategies.environment)::text = (feature_environments.environment)::text))))
     LEFT JOIN public.environments ON (((feature_environments.environment)::text = (environments.name)::text)))
     LEFT JOIN public.feature_strategy_segment fss ON ((fss.feature_strategy_id = feature_strategies.id)));


ALTER TABLE public.features_view OWNER TO smarttesting;

--
-- Name: group_role; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.group_role (
    group_id integer NOT NULL,
    role_id integer NOT NULL,
    created_by text,
    created_at timestamp with time zone DEFAULT now(),
    project text NOT NULL
);


ALTER TABLE public.group_role OWNER TO smarttesting;

--
-- Name: group_user; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.group_user (
    group_id integer NOT NULL,
    user_id integer NOT NULL,
    created_by text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.group_user OWNER TO smarttesting;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    created_by text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    mappings_sso jsonb DEFAULT '[]'::jsonb,
    root_role_id integer
);


ALTER TABLE public.groups OWNER TO smarttesting;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO smarttesting;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: login_history; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.login_history (
    id integer NOT NULL,
    username text NOT NULL,
    auth_type text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    successful boolean NOT NULL,
    ip inet,
    failure_reason text
);


ALTER TABLE public.login_history OWNER TO smarttesting;

--
-- Name: login_events_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.login_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_events_id_seq OWNER TO smarttesting;

--
-- Name: login_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.login_events_id_seq OWNED BY public.login_history.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    run_on timestamp without time zone NOT NULL
);


ALTER TABLE public.migrations OWNER TO smarttesting;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO smarttesting;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    event_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notifications OWNER TO smarttesting;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO smarttesting;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    permission character varying(255) NOT NULL,
    display_name text,
    type character varying(255),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.permissions OWNER TO smarttesting;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO smarttesting;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.personal_access_tokens (
    secret text NOT NULL,
    description text,
    user_id integer NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    seen_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.personal_access_tokens OWNER TO smarttesting;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO smarttesting;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: project_environments; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.project_environments (
    project_id character varying(255) NOT NULL,
    environment_name character varying(100) NOT NULL,
    default_strategy jsonb
);


ALTER TABLE public.project_environments OWNER TO smarttesting;

--
-- Name: project_settings; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.project_settings (
    project character varying(255) NOT NULL,
    default_stickiness character varying(100),
    project_mode character varying(100),
    feature_limit integer
);


ALTER TABLE public.project_settings OWNER TO smarttesting;

--
-- Name: project_stats; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.project_stats (
    project character varying(255) NOT NULL,
    avg_time_to_prod_current_window double precision DEFAULT 0,
    project_changes_current_window integer DEFAULT 0,
    project_changes_past_window integer DEFAULT 0,
    features_created_current_window integer DEFAULT 0,
    features_created_past_window integer DEFAULT 0,
    features_archived_current_window integer DEFAULT 0,
    features_archived_past_window integer DEFAULT 0,
    project_members_added_current_window integer DEFAULT 0
);


ALTER TABLE public.project_stats OWNER TO smarttesting;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.projects (
    id character varying(255) NOT NULL,
    name character varying NOT NULL,
    description character varying,
    created_at timestamp without time zone DEFAULT now(),
    health integer DEFAULT 100,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.projects OWNER TO smarttesting;

--
-- Name: public_signup_tokens; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.public_signup_tokens (
    secret text NOT NULL,
    name text,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by text,
    role_id integer NOT NULL,
    url text,
    enabled boolean DEFAULT true
);


ALTER TABLE public.public_signup_tokens OWNER TO smarttesting;

--
-- Name: public_signup_tokens_user; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.public_signup_tokens_user (
    secret text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.public_signup_tokens_user OWNER TO smarttesting;

--
-- Name: reset_tokens; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.reset_tokens (
    reset_token text NOT NULL,
    user_id integer,
    expires_at timestamp with time zone NOT NULL,
    used_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    created_by text
);


ALTER TABLE public.reset_tokens OWNER TO smarttesting;

--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.role_permission (
    role_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    permission_id integer,
    environment character varying(100)
);


ALTER TABLE public.role_permission OWNER TO smarttesting;

--
-- Name: role_user; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.role_user (
    role_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    project character varying(255) NOT NULL
);


ALTER TABLE public.role_user OWNER TO smarttesting;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    type text DEFAULT 'custom'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone
);


ALTER TABLE public.roles OWNER TO smarttesting;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO smarttesting;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: segments; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.segments (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    created_by text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    constraints jsonb DEFAULT '[]'::jsonb NOT NULL,
    segment_project_id character varying(255)
);


ALTER TABLE public.segments OWNER TO smarttesting;

--
-- Name: segments_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.segments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.segments_id_seq OWNER TO smarttesting;

--
-- Name: segments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.segments_id_seq OWNED BY public.segments.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.settings (
    name character varying(255) NOT NULL,
    content json
);


ALTER TABLE public.settings OWNER TO smarttesting;

--
-- Name: strategies; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.strategies (
    created_at timestamp with time zone DEFAULT now(),
    name character varying(255) NOT NULL,
    description text,
    parameters json,
    built_in integer DEFAULT 0,
    deprecated boolean DEFAULT false,
    sort_order integer DEFAULT 9999,
    display_name text,
    title text
);


ALTER TABLE public.strategies OWNER TO smarttesting;

--
-- Name: tag_types; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.tag_types (
    name text NOT NULL,
    description text,
    icon text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tag_types OWNER TO smarttesting;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.tags (
    type text NOT NULL,
    value text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tags OWNER TO smarttesting;

--
-- Name: unleash_session; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.unleash_session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.unleash_session OWNER TO smarttesting;

--
-- Name: user_feedback; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.user_feedback (
    user_id integer NOT NULL,
    feedback_id text NOT NULL,
    given timestamp with time zone,
    nevershow boolean DEFAULT false NOT NULL
);


ALTER TABLE public.user_feedback OWNER TO smarttesting;

--
-- Name: user_notifications; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.user_notifications (
    notification_id integer NOT NULL,
    user_id integer NOT NULL,
    read_at timestamp with time zone
);


ALTER TABLE public.user_notifications OWNER TO smarttesting;

--
-- Name: user_splash; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.user_splash (
    user_id integer NOT NULL,
    splash_id text NOT NULL,
    seen boolean DEFAULT false NOT NULL
);


ALTER TABLE public.user_splash OWNER TO smarttesting;

--
-- Name: users; Type: TABLE; Schema: public; Owner: smarttesting
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255),
    username character varying(255),
    email character varying(255),
    image_url character varying(255),
    password_hash character varying(255),
    login_attempts integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    seen_at timestamp without time zone,
    settings json,
    permissions json DEFAULT '[]'::json,
    deleted_at timestamp with time zone,
    is_service boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO smarttesting;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: smarttesting
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO smarttesting;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: smarttesting
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addons id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.addons ALTER COLUMN id SET DEFAULT nextval('public.addons_id_seq'::regclass);


--
-- Name: change_request_approvals id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_approvals ALTER COLUMN id SET DEFAULT nextval('public.change_request_approvals_id_seq'::regclass);


--
-- Name: change_request_comments id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_comments ALTER COLUMN id SET DEFAULT nextval('public.change_request_comments_id_seq'::regclass);


--
-- Name: change_request_events id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_events ALTER COLUMN id SET DEFAULT nextval('public.change_request_events_id_seq'::regclass);


--
-- Name: change_request_rejections id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_rejections ALTER COLUMN id SET DEFAULT nextval('public.change_request_rejections_id_seq'::regclass);


--
-- Name: change_requests id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_requests ALTER COLUMN id SET DEFAULT nextval('public.change_requests_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: login_history id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.login_history ALTER COLUMN id SET DEFAULT nextval('public.login_events_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: segments id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.segments ALTER COLUMN id SET DEFAULT nextval('public.segments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: addons; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.addons (id, provider, description, enabled, parameters, events, created_at, projects, environments) FROM stdin;
\.


--
-- Data for Name: api_token_project; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.api_token_project (secret, project) FROM stdin;
\.


--
-- Data for Name: api_tokens; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.api_tokens (secret, username, type, created_at, expires_at, seen_at, environment, alias, token_name) FROM stdin;
*:development.7acc69a05927e1751aed83f410a1ecb562cfbb0f0d57d05e02afd224	client-token	client	2023-09-15 20:26:37.772705+00	\N	\N	development	\N	client-token
\.


--
-- Data for Name: change_request_approvals; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.change_request_approvals (id, change_request_id, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: change_request_comments; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.change_request_comments (id, change_request, text, created_at, created_by) FROM stdin;
\.


--
-- Data for Name: change_request_events; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.change_request_events (id, feature, action, payload, created_by, created_at, change_request_id) FROM stdin;
\.


--
-- Data for Name: change_request_rejections; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.change_request_rejections (id, change_request_id, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: change_request_settings; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.change_request_settings (project, environment, required_approvals) FROM stdin;
\.


--
-- Data for Name: change_requests; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.change_requests (id, environment, state, project, created_by, created_at, min_approvals, title) FROM stdin;
\.


--
-- Data for Name: client_applications; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.client_applications (app_name, created_at, updated_at, seen_at, strategies, description, icon, url, color, announced, created_by) FROM stdin;
\.


--
-- Data for Name: client_applications_usage; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.client_applications_usage (app_name, project, environment) FROM stdin;
\.


--
-- Data for Name: client_instances; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.client_instances (app_name, instance_id, client_ip, last_seen, created_at, sdk_version, environment) FROM stdin;
\.


--
-- Data for Name: client_metrics_env; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.client_metrics_env (feature_name, app_name, environment, "timestamp", yes, no) FROM stdin;
\.


--
-- Data for Name: client_metrics_env_variants; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.client_metrics_env_variants (feature_name, app_name, environment, "timestamp", variant, count) FROM stdin;
\.


--
-- Data for Name: context_fields; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.context_fields (name, description, sort_order, legal_values, created_at, updated_at, stickiness) FROM stdin;
environment	Allows you to constrain on application environment	0	\N	2023-09-15 20:20:48.533458	2023-09-15 20:20:48.533458	f
userId	Allows you to constrain on userId	1	\N	2023-09-15 20:20:48.533458	2023-09-15 20:20:48.533458	f
appName	Allows you to constrain on application name	2	\N	2023-09-15 20:20:48.533458	2023-09-15 20:20:48.533458	f
currentTime	Allows you to constrain on date values	3	\N	2023-09-15 20:20:49.144431	2023-09-15 20:20:49.144431	f
sessionId	Allows you to constrain on sessionId	4	\N	2023-09-15 20:20:49.513598	2023-09-15 20:20:49.513598	t
\.


--
-- Data for Name: environments; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.environments (name, created_at, sort_order, type, enabled, protected) FROM stdin;
default	2023-09-15 20:20:48.942209+00	1	production	f	t
development	2023-09-15 20:20:48.962503+00	2	development	t	f
production	2023-09-15 20:20:48.962503+00	3	production	t	f
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.events (id, created_at, type, created_by, data, tags, project, environment, feature_name, pre_data, announced) FROM stdin;
1	2023-09-15 20:20:48.413831+00	strategy-created	migration	{"name":"default","description":"Default on or off Strategy."}	[]	\N	\N	\N	\N	t
2	2023-09-15 20:20:48.471601+00	strategy-created	migration	{"name":"userWithId","description":"Active for users with a userId defined in the userIds-list","parameters":[{"name":"userIds","type":"list","description":"","required":false}]}	[]	\N	\N	\N	\N	t
3	2023-09-15 20:20:48.471601+00	strategy-created	migration	{"name":"applicationHostname","description":"Active for client instances with a hostName in the hostNames-list.","parameters":[{"name":"hostNames","type":"list","description":"List of hostnames to enable the feature toggle for.","required":false}]}	[]	\N	\N	\N	\N	t
4	2023-09-15 20:20:48.471601+00	strategy-created	migration	{"name":"remoteAddress","description":"Active for remote addresses defined in the IPs list.","parameters":[{"name":"IPs","type":"list","description":"List of IPs to enable the feature toggle for.","required":true}]}	[]	\N	\N	\N	\N	t
5	2023-09-15 20:20:48.528953+00	strategy-created	migration	{"name":"flexibleRollout","description":"Gradually activate feature toggle based on sane stickiness","parameters":[{"name":"rollout","type":"percentage","description":"","required":false},{"name":"stickiness","type":"string","description":"Used define stickiness. Possible values: default, userId, sessionId, random","required":true},{"name":"groupId","type":"string","description":"Used to define a activation groups, which allows you to correlate across feature toggles.","required":true}]}	[]	\N	\N	\N	\N	t
6	2023-09-15 20:25:44.733257+00	feature-created	admin	{"name":"NewVerification","description":null,"type":"experiment","project":"default","stale":false,"createdAt":"2023-09-15T20:25:44.723Z","lastSeenAt":null,"impressionData":false,"archivedAt":null,"archived":false}	[]	default	\N	NewVerification	\N	t
7	2023-09-15 20:25:58.977776+00	feature-strategy-add	admin	{"id":"ed11dc16-85a7-44ea-a0b8-581e9f317da8","name":"flexibleRollout","title":null,"disabled":false,"constraints":[],"parameters":{"groupId":"NewVerification","rollout":"100","stickiness":"default"},"segments":[]}	[]	default	development	NewVerification	\N	t
8	2023-09-15 20:25:58.98515+00	feature-environment-enabled	admin	\N	[]	default	development	NewVerification	\N	t
9	2023-09-15 20:25:59.455722+00	feature-strategy-add	admin	{"id":"0f7e4e7a-660a-4c8e-a829-e899e118e8a5","name":"flexibleRollout","title":null,"disabled":false,"constraints":[],"parameters":{"groupId":"NewVerification","rollout":"100","stickiness":"default"},"segments":[]}	[]	default	production	NewVerification	\N	t
10	2023-09-15 20:25:59.462643+00	feature-environment-enabled	admin	\N	[]	default	production	NewVerification	\N	t
11	2023-09-15 20:26:00.124603+00	feature-environment-disabled	admin	\N	[]	default	development	NewVerification	\N	t
12	2023-09-15 20:26:01.778585+00	feature-environment-disabled	admin	\N	[]	default	production	NewVerification	\N	t
13	2023-09-15 20:26:37.780268+00	api-token-created	admin	{"tokenName":"client-token","type":"client","environment":"development","projects":["*"],"username":"client-token","alias":null,"project":"*","createdAt":"2023-09-15T20:26:37.772Z"}	[]	*	development	\N	\N	t
\.


--
-- Data for Name: favorite_features; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.favorite_features (feature, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: favorite_projects; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.favorite_projects (project, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: feature_environments; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.feature_environments (environment, feature_name, enabled, variants, last_seen_at) FROM stdin;
development	NewVerification	f	[]	\N
production	NewVerification	f	[]	\N
\.


--
-- Data for Name: feature_strategies; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.feature_strategies (id, feature_name, project_name, environment, strategy_name, parameters, constraints, sort_order, created_at, title, disabled, variants) FROM stdin;
ed11dc16-85a7-44ea-a0b8-581e9f317da8	NewVerification	default	development	flexibleRollout	{"groupId": "NewVerification", "rollout": "100", "stickiness": "default"}	[]	0	2023-09-15 20:25:58.970489+00	\N	f	[]
0f7e4e7a-660a-4c8e-a829-e899e118e8a5	NewVerification	default	production	flexibleRollout	{"groupId": "NewVerification", "rollout": "100", "stickiness": "default"}	[]	0	2023-09-15 20:25:59.449122+00	\N	f	[]
\.


--
-- Data for Name: feature_strategy_segment; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.feature_strategy_segment (feature_strategy_id, segment_id, created_at) FROM stdin;
\.


--
-- Data for Name: feature_tag; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.feature_tag (feature_name, tag_type, tag_value, created_at) FROM stdin;
\.


--
-- Data for Name: feature_types; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.feature_types (id, name, description, lifetime_days, created_at) FROM stdin;
release	Release	Release feature toggles are used to release new features.	40	2023-09-15 20:20:48.594619+00
experiment	Experiment	Experiment feature toggles are used to test and verify multiple different versions of a feature.	40	2023-09-15 20:20:48.594619+00
operational	Operational	Operational feature toggles are used to control aspects of a rollout.	7	2023-09-15 20:20:48.594619+00
kill-switch	Kill switch	Kill switch feature toggles are used to quickly turn on or off critical functionality in your system.	\N	2023-09-15 20:20:48.594619+00
permission	Permission	Permission feature toggles are used to control permissions in your system.	\N	2023-09-15 20:20:48.594619+00
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.features (created_at, name, description, archived, variants, type, stale, project, last_seen_at, impression_data, archived_at, potentially_stale) FROM stdin;
2023-09-15 20:25:44.723894+00	NewVerification	\N	f	[]	experiment	f	default	\N	f	\N	\N
\.


--
-- Data for Name: group_role; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.group_role (group_id, role_id, created_by, created_at, project) FROM stdin;
\.


--
-- Data for Name: group_user; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.group_user (group_id, user_id, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.groups (id, name, description, created_by, created_at, mappings_sso, root_role_id) FROM stdin;
\.


--
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.login_history (id, username, auth_type, created_at, successful, ip, failure_reason) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.migrations (id, name, run_on) FROM stdin;
1	/20141020151056-initial-schema	2023-09-15 20:20:48.394
2	/20141110144153-add-description-to-features	2023-09-15 20:20:48.403
3	/20141117200435-add-parameters-template-to-strategies	2023-09-15 20:20:48.407
4	/20141117202209-insert-default-strategy	2023-09-15 20:20:48.411
5	/20141118071458-default-strategy-event	2023-09-15 20:20:48.415
6	/20141215210141-005-archived-flag-to-features	2023-09-15 20:20:48.419
7	/20150210152531-006-rename-eventtype	2023-09-15 20:20:48.423
8	/20160618193924-add-strategies-to-features	2023-09-15 20:20:48.427
9	/20161027134128-create-metrics	2023-09-15 20:20:48.436
10	/20161104074441-create-client-instances	2023-09-15 20:20:48.443
11	/20161205203516-create-client-applications	2023-09-15 20:20:48.451
12	/20161212101749-better-strategy-parameter-definitions	2023-09-15 20:20:48.464
13	/20170211085502-built-in-strategies	2023-09-15 20:20:48.469
14	/20170211090541-add-default-strategies	2023-09-15 20:20:48.477
15	/20170306233934-timestamp-with-tz	2023-09-15 20:20:48.519
16	/20170628205541-add-sdk-version-to-client-instances	2023-09-15 20:20:48.523
17	/20190123204125-add-variants-to-features	2023-09-15 20:20:48.526
18	/20191023184858-flexible-rollout-strategy	2023-09-15 20:20:48.531
19	/20200102184820-create-context-fields	2023-09-15 20:20:48.54
20	/20200227202711-settings	2023-09-15 20:20:48.548
21	/20200329191251-settings-secret	2023-09-15 20:20:48.552
22	/20200416201319-create-users	2023-09-15 20:20:48.565
23	/20200429175747-users-settings	2023-09-15 20:20:48.569
24	/20200805091409-add-feature-toggle-type	2023-09-15 20:20:48.579
25	/20200805094311-add-feature-type-to-features	2023-09-15 20:20:48.588
26	/20200806091734-add-stale-flag-to-features	2023-09-15 20:20:48.592
27	/20200810200901-add-created-at-to-feature-types	2023-09-15 20:20:48.596
28	/20200928194947-add-projects	2023-09-15 20:20:48.605
29	/20200928195238-add-project-id-to-features	2023-09-15 20:20:48.609
30	/20201216140726-add-last-seen-to-features	2023-09-15 20:20:48.612
31	/20210105083014-add-tag-and-tag-types	2023-09-15 20:20:48.63
32	/20210119084617-add-addon-table	2023-09-15 20:20:48.638
33	/20210121115438-add-deprecated-column-to-strategies	2023-09-15 20:20:48.643
34	/20210127094440-add-tags-column-to-events	2023-09-15 20:20:48.648
35	/20210208203708-add-stickiness-to-context	2023-09-15 20:20:48.653
36	/20210212114759-add-session-table	2023-09-15 20:20:48.665
37	/20210217195834-rbac-tables	2023-09-15 20:20:48.681
38	/20210218090213-generate-server-identifier	2023-09-15 20:20:48.686
39	/20210302080040-add-pk-to-client-instances	2023-09-15 20:20:48.73
40	/20210304115810-change-default-timestamp-to-now	2023-09-15 20:20:48.735
41	/20210304141005-add-announce-field-to-application	2023-09-15 20:20:48.74
42	/20210304150739-add-created-by-to-application	2023-09-15 20:20:48.743
43	/20210322104356-api-tokens-table	2023-09-15 20:20:48.752
44	/20210322104357-api-tokens-convert-enterprise	2023-09-15 20:20:48.756
45	/20210323073508-reset-application-announcements	2023-09-15 20:20:48.759
46	/20210409120136-create-reset-token-table	2023-09-15 20:20:48.768
47	/20210414141220-fix-misspellings-in-role-descriptions	2023-09-15 20:20:48.772
48	/20210415173116-rbac-rename-roles	2023-09-15 20:20:48.776
49	/20210421133845-add-sort-order-to-strategies	2023-09-15 20:20:48.78
50	/20210421135405-add-display-name-and-update-description-for-strategies	2023-09-15 20:20:48.783
51	/20210423103647-lowercase-all-emails	2023-09-15 20:20:48.788
52	/20210428062103-user-permission-to-rbac	2023-09-15 20:20:48.792
53	/20210428103922-patch-role-table	2023-09-15 20:20:48.796
54	/20210428103923-onboard-projects-to-rbac	2023-09-15 20:20:48.801
55	/20210428103924-patch-admin-role-name	2023-09-15 20:20:48.805
56	/20210428103924-patch-admin_role	2023-09-15 20:20:48.809
57	/20210428103924-patch-role_permissions	2023-09-15 20:20:48.814
58	/20210504101429-deprecate-strategies	2023-09-15 20:20:48.817
59	/20210520171325-update-role-descriptions	2023-09-15 20:20:48.821
60	/20210602115555-create-feedback-table	2023-09-15 20:20:48.832
61	/20210610085817-features-strategies-table	2023-09-15 20:20:48.845
62	/20210615115226-migrate-strategies-to-feature-strategies	2023-09-15 20:20:48.849
63	/20210618091331-project-environments-table	2023-09-15 20:20:48.855
64	/20210618100913-add-cascade-for-user-feedback	2023-09-15 20:20:48.859
65	/20210624114602-change-type-of-feature-archived	2023-09-15 20:20:48.868
66	/20210624114855-drop-strategies-column-from-features	2023-09-15 20:20:48.872
67	/20210624115109-drop-enabled-column-from-features	2023-09-15 20:20:48.876
68	/20210625102126-connect-default-project-to-global-environment	2023-09-15 20:20:48.879
69	/20210629130734-add-health-rating-to-project	2023-09-15 20:20:48.883
70	/20210830113948-connect-projects-to-global-envrionments	2023-09-15 20:20:48.887
71	/20210831072631-add-sort-order-and-type-to-env	2023-09-15 20:20:48.895
72	/20210907124058-add-dbcritic-indices	2023-09-15 20:20:48.915
73	/20210907124850-add-dbcritic-primary-keys	2023-09-15 20:20:48.92
74	/20210908100701-add-enabled-to-environments	2023-09-15 20:20:48.924
75	/20210909085651-add-protected-field-to-environments	2023-09-15 20:20:48.927
76	/20210913103159-api-keys-scoping	2023-09-15 20:20:48.931
77	/20210915122001-add-project-and-environment-columns-to-events	2023-09-15 20:20:48.94
78	/20210920104218-rename-global-env-to-default-env	2023-09-15 20:20:48.944
79	/20210921105032-client-api-tokens-default	2023-09-15 20:20:48.948
80	/20210922084509-add-non-null-constraint-to-environment-type	2023-09-15 20:20:48.952
81	/20210922120521-add-tag-type-permission	2023-09-15 20:20:48.956
82	/20210928065411-remove-displayname-from-environments	2023-09-15 20:20:48.96
83	/20210928080601-add-development-and-production-environments	2023-09-15 20:20:48.963
84	/20210928082228-connect-default-environment-to-all-existing-projects	2023-09-15 20:20:48.967
85	/20211004104917-client-metrics-env	2023-09-15 20:20:48.977
86	/20211011094226-add-environment-to-client-instances	2023-09-15 20:20:48.986
87	/20211013093114-feature-strategies-parameters-not-null	2023-09-15 20:20:48.99
88	/20211029094324-set-sort-order-env	2023-09-15 20:20:48.994
89	/20211105104316-add-feature-name-column-to-events	2023-09-15 20:20:48.999
90	/20211105105509-add-predata-column-to-events	2023-09-15 20:20:49.003
91	/20211108130333-create-user-splash-table	2023-09-15 20:20:49.013
92	/20211109103930-add-splash-entry-for-users	2023-09-15 20:20:49.017
93	/20211126112551-disable-default-environment	2023-09-15 20:20:49.021
94	/20211130142314-add-updated-at-to-projects	2023-09-15 20:20:49.025
95	/20211202120808-add-custom-roles	2023-09-15 20:20:49.042
96	/20211209205201-drop-client-metrics	2023-09-15 20:20:49.048
97	/20220103134659-add-permissions-to-project-roles	2023-09-15 20:20:49.053
98	/20220103143843-add-permissions-to-editor-role	2023-09-15 20:20:49.057
99	/20220111112804-update-permission-descriptions	2023-09-15 20:20:49.062
100	/20220111115613-move-feature-toggle-permission	2023-09-15 20:20:49.065
101	/20220111120346-roles-unique-name	2023-09-15 20:20:49.071
102	/20220111121010-update-project-for-editor-role	2023-09-15 20:20:49.076
103	/20220111125620-role-permission-empty-string-for-non-environment-type	2023-09-15 20:20:49.113
104	/20220119182603-update-toggle-types-description	2023-09-15 20:20:49.117
105	/20220125200908-convert-old-feature-events	2023-09-15 20:20:49.121
106	/20220128081242-add-impressiondata-to-features	2023-09-15 20:20:49.125
107	/20220129113106-metrics-counters-as-bigint	2023-09-15 20:20:49.135
108	/20220131082150-reset-feedback-form	2023-09-15 20:20:49.139
109	/20220224081422-remove-project-column-from-roles	2023-09-15 20:20:49.142
110	/20220224111626-add-current-time-context-field	2023-09-15 20:20:49.145
111	/20220307130902-add-segments	2023-09-15 20:20:49.161
112	/20220331085057-add-api-link-table	2023-09-15 20:20:49.168
113	/20220405103233-add-segments-name-index	2023-09-15 20:20:49.175
114	/20220408081222-clean-up-duplicate-foreign-key-role-permission	2023-09-15 20:20:49.178
115	/20220411103724-add-legal-value-description	2023-09-15 20:20:49.187
116	/20220425090847-add-token-permission	2023-09-15 20:20:49.191
117	/20220511111823-patch-broken-feature-strategies	2023-09-15 20:20:49.195
118	/20220511124923-fix-patch-broken-feature-strategies	2023-09-15 20:20:49.198
119	/20220528143630-dont-cascade-environment-deletion-to-apitokens	2023-09-15 20:20:49.202
120	/20220603081324-add-archive-at-to-feature-toggle	2023-09-15 20:20:49.206
121	/20220704115624-add-user-groups	2023-09-15 20:20:49.225
122	/20220711084613-add-projects-and-environments-for-addons	2023-09-15 20:20:49.228
123	/20220808084524-add-group-permissions	2023-09-15 20:20:49.232
124	/20220808110415-add-projects-foreign-key	2023-09-15 20:20:49.236
125	/20220816121136-add-metadata-to-api-keys	2023-09-15 20:20:49.24
126	/20220817130250-alter-api-tokens	2023-09-15 20:20:49.244
127	/20220908093515-add-public-signup-tokens	2023-09-15 20:20:49.261
128	/20220912165344-pat-tokens	2023-09-15 20:20:49.269
129	/20220916093515-add-url-to-public-signup-tokens	2023-09-15 20:20:49.273
130	/20220927110212-add-enabled-to-public-signup-tokens	2023-09-15 20:20:49.277
131	/20221010114644-pat-auto-increment	2023-09-15 20:20:49.286
132	/20221011155007-add-user-groups-mappings	2023-09-15 20:20:49.291
133	/20221103111940-fix-migrations	2023-09-15 20:20:49.294
134	/20221103112200-change-request	2023-09-15 20:20:49.312
135	/20221103125732-change-request-remove-unique	2023-09-15 20:20:49.316
136	/20221104123349-change-request-approval	2023-09-15 20:20:49.324
137	/20221107121635-move-variants-to-per-environment	2023-09-15 20:20:49.332
138	/20221107132528-change-request-project-options	2023-09-15 20:20:49.335
139	/20221108114358-add-change-request-permissions	2023-09-15 20:20:49.339
140	/20221110104933-add-change-request-settings	2023-09-15 20:20:49.346
141	/20221110144113-revert-change-request-project-options	2023-09-15 20:20:49.35
142	/20221114150559-change-request-comments	2023-09-15 20:20:49.359
143	/20221115072335-add-required-approvals	2023-09-15 20:20:49.364
144	/20221121114357-add-permission-for-environment-variants	2023-09-15 20:20:49.369
145	/20221121133546-soft-delete-user	2023-09-15 20:20:49.373
146	/20221124123914-add-favorites	2023-09-15 20:20:49.382
147	/20221125185244-change-request-unique-approvals	2023-09-15 20:20:49.387
148	/20221128165141-change-request-min-approvals	2023-09-15 20:20:49.39
149	/20221205122253-skip-change-request	2023-09-15 20:20:49.393
150	/20221220160345-user-pat-permissions	2023-09-15 20:20:49.396
151	/20221221144132-service-account-users	2023-09-15 20:20:49.4
152	/20230125065315-project-stats-table	2023-09-15 20:20:49.406
153	/20230127111638-new-project-stats-field	2023-09-15 20:20:49.409
154	/20230130113337-revert-user-pat-permissions	2023-09-15 20:20:49.412
155	/20230208084046-project-api-token-permissions	2023-09-15 20:20:49.415
156	/20230208093627-assign-project-api-token-permissions-editor	2023-09-15 20:20:49.419
157	/20230208093750-assign-project-api-token-permissions-owner	2023-09-15 20:20:49.423
158	/20230208093942-assign-project-api-token-permissions-member	2023-09-15 20:20:49.427
159	/20230222084211-add-login-events-table	2023-09-15 20:20:49.438
160	/20230222154915-create-notiications-table	2023-09-15 20:20:49.448
161	/20230224093446-drop-createdBy-from-notifications-table	2023-09-15 20:20:49.452
162	/20230227115320-rename-login-events-table-to-sign-on-log	2023-09-15 20:20:49.456
163	/20230227120500-change-display-name-for-variants-per-env-permission	2023-09-15 20:20:49.459
164	/20230227123106-add-setting-for-sign-on-log-retention	2023-09-15 20:20:49.463
165	/20230302133740-rename-sign-on-log-table-to-login-history	2023-09-15 20:20:49.467
166	/20230306103400-add-project-column-to-segments	2023-09-15 20:20:49.472
167	/20230306103400-remove-direct-link-from-segment-permissions-to-admin	2023-09-15 20:20:49.475
168	/20230309174400-add-project-segment-permission	2023-09-15 20:20:49.478
169	/20230314131041-project-settings	2023-09-15 20:20:49.484
170	/20230316092547-remove-project-stats-column	2023-09-15 20:20:49.487
171	/20230411085947-skip-change-request-ui	2023-09-15 20:20:49.491
172	/20230412062635-add-change-request-title	2023-09-15 20:20:49.494
173	/20230412125618-add-title-to-strategy	2023-09-15 20:20:49.499
174	/20230414105818-add-root-role-to-groups	2023-09-15 20:20:49.503
175	/20230419104126-add-disabled-field-to-feature-strategy	2023-09-15 20:20:49.507
176	/20230420125500-v5-strategy-changes	2023-09-15 20:20:49.511
177	/20230420211308-update-context-fields-add-sessionId	2023-09-15 20:20:49.515
178	/20230424090942-project-default-strategy-settings	2023-09-15 20:20:49.521
179	/20230504145945-variant-metrics	2023-09-15 20:20:49.53
180	/20230510113903-fix-api-token-username-migration	2023-09-15 20:20:49.533
181	/20230615122909-fix-env-sort-order	2023-09-15 20:20:49.537
182	/20230619105029-new-fine-grained-api-token-permissions	2023-09-15 20:20:49.54
183	/20230619110243-assign-apitoken-permissions-to-rootroles	2023-09-15 20:20:49.544
184	/20230621141239-refactor-api-token-permissions	2023-09-15 20:20:49.547
185	/20230630080126-delete-deprecated-permissions	2023-09-15 20:20:49.551
186	/20230706123907-events-announced-column	2023-09-15 20:20:49.553
187	/20230711094214-add-potentially-stale-flag	2023-09-15 20:20:49.557
188	/20230711163311-project-feature-limit	2023-09-15 20:20:49.56
189	/20230712091834-strategy-variants	2023-09-15 20:20:49.565
190	/20230802092725-add-last-seen-column-to-feature-environments	2023-09-15 20:20:49.57
191	/20230802141830-add-feature-and-environment-last-seen-at-to-features-view	2023-09-15 20:20:49.575
192	/20230803061359-change-request-optional-feature	2023-09-15 20:20:49.578
193	/20230808104232-update-root-roles-descriptions	2023-09-15 20:20:49.581
194	/20230814095253-change-request-rejections	2023-09-15 20:20:49.59
195	/20230814115436-change-request-timzone-timestamps	2023-09-15 20:20:49.595
196	/20230815065908-change-request-approve-reject-permission	2023-09-15 20:20:49.6
197	/20230817095805-client-applications-usage-table	2023-09-15 20:20:49.608
198	/20230818124614-update-client-applications-usage-table	2023-09-15 20:20:49.62
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.notifications (id, event_id, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.permissions (id, permission, display_name, type, created_at) FROM stdin;
1	ADMIN	Admin	root	2023-09-15 20:20:49.027495+00
2	CREATE_FEATURE	Create feature toggles	project	2023-09-15 20:20:49.027495+00
3	CREATE_STRATEGY	Create activation strategies	root	2023-09-15 20:20:49.027495+00
4	CREATE_ADDON	Create addons	root	2023-09-15 20:20:49.027495+00
5	DELETE_ADDON	Delete addons	root	2023-09-15 20:20:49.027495+00
6	UPDATE_ADDON	Update addons	root	2023-09-15 20:20:49.027495+00
7	UPDATE_FEATURE	Update feature toggles	project	2023-09-15 20:20:49.027495+00
8	DELETE_FEATURE	Delete feature toggles	project	2023-09-15 20:20:49.027495+00
9	UPDATE_APPLICATION	Update applications	root	2023-09-15 20:20:49.027495+00
10	UPDATE_TAG_TYPE	Update tag types	root	2023-09-15 20:20:49.027495+00
11	DELETE_TAG_TYPE	Delete tag types	root	2023-09-15 20:20:49.027495+00
12	CREATE_PROJECT	Create projects	root	2023-09-15 20:20:49.027495+00
13	UPDATE_PROJECT	Update project	project	2023-09-15 20:20:49.027495+00
14	DELETE_PROJECT	Delete project	project	2023-09-15 20:20:49.027495+00
15	UPDATE_STRATEGY	Update strategies	root	2023-09-15 20:20:49.027495+00
16	DELETE_STRATEGY	Delete strategies	root	2023-09-15 20:20:49.027495+00
17	UPDATE_CONTEXT_FIELD	Update context fields	root	2023-09-15 20:20:49.027495+00
18	CREATE_CONTEXT_FIELD	Create context fields	root	2023-09-15 20:20:49.027495+00
19	DELETE_CONTEXT_FIELD	Delete context fields	root	2023-09-15 20:20:49.027495+00
20	READ_ROLE	Read roles	root	2023-09-15 20:20:49.027495+00
25	CREATE_FEATURE_STRATEGY	Create activation strategies	environment	2023-09-15 20:20:49.027495+00
26	UPDATE_FEATURE_STRATEGY	Update activation strategies	environment	2023-09-15 20:20:49.027495+00
27	DELETE_FEATURE_STRATEGY	Delete activation strategies	environment	2023-09-15 20:20:49.027495+00
50	CREATE_CLIENT_API_TOKEN	Create CLIENT API tokens	root	2023-09-15 20:20:49.539321+00
29	UPDATE_FEATURE_VARIANTS	Create/edit variants	project	2023-09-15 20:20:49.027495+00
30	MOVE_FEATURE_TOGGLE	Change feature toggle project	project	2023-09-15 20:20:49.063959+00
31	CREATE_SEGMENT	Create segments	root	2023-09-15 20:20:49.147478+00
32	UPDATE_SEGMENT	Edit segments	root	2023-09-15 20:20:49.147478+00
33	DELETE_SEGMENT	Delete segments	root	2023-09-15 20:20:49.147478+00
42	READ_PROJECT_API_TOKEN	Read api tokens for a specific project	project	2023-09-15 20:20:49.414402+00
43	CREATE_PROJECT_API_TOKEN	Create api tokens for a specific project	project	2023-09-15 20:20:49.414402+00
44	DELETE_PROJECT_API_TOKEN	Delete api tokens for a specific project	project	2023-09-15 20:20:49.414402+00
37	UPDATE_FEATURE_ENVIRONMENT_VARIANTS	Update variants	environment	2023-09-15 20:20:49.367647+00
28	UPDATE_FEATURE_ENVIRONMENT	Enable/disable toggles	environment	2023-09-15 20:20:49.027495+00
36	APPLY_CHANGE_REQUEST	Apply change requests	environment	2023-09-15 20:20:49.337797+00
51	UPDATE_CLIENT_API_TOKEN	Update CLIENT API tokens	root	2023-09-15 20:20:49.539321+00
45	UPDATE_PROJECT_SEGMENT	Create/edit project segment	project	2023-09-15 20:20:49.477369+00
38	SKIP_CHANGE_REQUEST	Skip change request process	environment	2023-09-15 20:20:49.392256+00
52	DELETE_CLIENT_API_TOKEN	Delete CLIENT API tokens	root	2023-09-15 20:20:49.539321+00
53	READ_CLIENT_API_TOKEN	Read CLIENT API tokens	root	2023-09-15 20:20:49.539321+00
35	APPROVE_CHANGE_REQUEST	Approve/Reject change requests	environment	2023-09-15 20:20:49.337797+00
54	CREATE_FRONTEND_API_TOKEN	Create FRONTEND API tokens	root	2023-09-15 20:20:49.539321+00
55	UPDATE_FRONTEND_API_TOKEN	Update FRONTEND API tokens	root	2023-09-15 20:20:49.539321+00
56	DELETE_FRONTEND_API_TOKEN	Delete FRONTEND API tokens	root	2023-09-15 20:20:49.539321+00
57	READ_FRONTEND_API_TOKEN	Read FRONTEND API tokens	root	2023-09-15 20:20:49.539321+00
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.personal_access_tokens (secret, description, user_id, expires_at, seen_at, created_at, id) FROM stdin;
\.


--
-- Data for Name: project_environments; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.project_environments (project_id, environment_name, default_strategy) FROM stdin;
default	development	\N
default	production	\N
\.


--
-- Data for Name: project_settings; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.project_settings (project, default_stickiness, project_mode, feature_limit) FROM stdin;
\.


--
-- Data for Name: project_stats; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.project_stats (project, avg_time_to_prod_current_window, project_changes_current_window, project_changes_past_window, features_created_current_window, features_created_past_window, features_archived_current_window, features_archived_past_window, project_members_added_current_window) FROM stdin;
default	0	7	0	1	0	0	0	0
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.projects (id, name, description, created_at, health, updated_at) FROM stdin;
default	Default	Default project	2023-09-15 20:20:48.59852	100	2023-09-15 20:29:55.936+00
\.


--
-- Data for Name: public_signup_tokens; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.public_signup_tokens (secret, name, expires_at, created_at, created_by, role_id, url, enabled) FROM stdin;
\.


--
-- Data for Name: public_signup_tokens_user; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.public_signup_tokens_user (secret, user_id, created_at) FROM stdin;
\.


--
-- Data for Name: reset_tokens; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.reset_tokens (reset_token, user_id, expires_at, used_at, created_at, created_by) FROM stdin;
\.


--
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.role_permission (role_id, created_at, permission_id, environment) FROM stdin;
4	2023-09-15 20:20:49.050656+00	25	development
4	2023-09-15 20:20:49.050656+00	26	development
4	2023-09-15 20:20:49.050656+00	27	development
4	2023-09-15 20:20:49.050656+00	28	development
4	2023-09-15 20:20:49.050656+00	25	production
4	2023-09-15 20:20:49.050656+00	26	production
4	2023-09-15 20:20:49.050656+00	27	production
4	2023-09-15 20:20:49.050656+00	28	production
4	2023-09-15 20:20:49.050656+00	25	default
4	2023-09-15 20:20:49.050656+00	26	default
4	2023-09-15 20:20:49.050656+00	27	default
4	2023-09-15 20:20:49.050656+00	28	default
5	2023-09-15 20:20:49.050656+00	25	development
5	2023-09-15 20:20:49.050656+00	26	development
5	2023-09-15 20:20:49.050656+00	27	development
5	2023-09-15 20:20:49.050656+00	28	development
5	2023-09-15 20:20:49.050656+00	25	production
5	2023-09-15 20:20:49.050656+00	26	production
5	2023-09-15 20:20:49.050656+00	27	production
5	2023-09-15 20:20:49.050656+00	28	production
5	2023-09-15 20:20:49.050656+00	25	default
5	2023-09-15 20:20:49.050656+00	26	default
5	2023-09-15 20:20:49.050656+00	27	default
5	2023-09-15 20:20:49.050656+00	28	default
2	2023-09-15 20:20:49.055326+00	25	development
2	2023-09-15 20:20:49.055326+00	26	development
2	2023-09-15 20:20:49.055326+00	27	development
2	2023-09-15 20:20:49.055326+00	28	development
2	2023-09-15 20:20:49.055326+00	25	production
2	2023-09-15 20:20:49.055326+00	26	production
2	2023-09-15 20:20:49.055326+00	27	production
2	2023-09-15 20:20:49.055326+00	28	production
2	2023-09-15 20:20:49.055326+00	25	default
2	2023-09-15 20:20:49.055326+00	26	default
2	2023-09-15 20:20:49.055326+00	27	default
2	2023-09-15 20:20:49.055326+00	28	default
2	2023-09-15 20:20:49.027495+00	2	
2	2023-09-15 20:20:49.027495+00	3	
2	2023-09-15 20:20:49.027495+00	4	
2	2023-09-15 20:20:49.027495+00	5	
2	2023-09-15 20:20:49.027495+00	6	
2	2023-09-15 20:20:49.027495+00	7	
2	2023-09-15 20:20:49.027495+00	8	
2	2023-09-15 20:20:49.027495+00	9	
2	2023-09-15 20:20:49.027495+00	10	
2	2023-09-15 20:20:49.027495+00	11	
2	2023-09-15 20:20:49.027495+00	12	
2	2023-09-15 20:20:49.027495+00	13	
2	2023-09-15 20:20:49.027495+00	14	
2	2023-09-15 20:20:49.027495+00	15	
2	2023-09-15 20:20:49.027495+00	16	
2	2023-09-15 20:20:49.027495+00	17	
2	2023-09-15 20:20:49.027495+00	18	
2	2023-09-15 20:20:49.027495+00	19	
2	2023-09-15 20:20:49.027495+00	29	
4	2023-09-15 20:20:49.027495+00	2	
4	2023-09-15 20:20:49.027495+00	7	
4	2023-09-15 20:20:49.027495+00	8	
4	2023-09-15 20:20:49.027495+00	13	
4	2023-09-15 20:20:49.027495+00	14	
4	2023-09-15 20:20:49.027495+00	29	
5	2023-09-15 20:20:49.027495+00	2	
5	2023-09-15 20:20:49.027495+00	7	
5	2023-09-15 20:20:49.027495+00	8	
5	2023-09-15 20:20:49.027495+00	29	
1	2023-09-15 20:20:49.027495+00	1	
2	2023-09-15 20:20:49.063959+00	30	
4	2023-09-15 20:20:49.063959+00	30	
2	2023-09-15 20:20:49.147478+00	31	\N
2	2023-09-15 20:20:49.147478+00	32	\N
2	2023-09-15 20:20:49.147478+00	33	\N
4	2023-09-15 20:20:49.367647+00	37	development
4	2023-09-15 20:20:49.367647+00	37	production
4	2023-09-15 20:20:49.367647+00	37	default
5	2023-09-15 20:20:49.367647+00	37	development
5	2023-09-15 20:20:49.367647+00	37	production
5	2023-09-15 20:20:49.367647+00	37	default
2	2023-09-15 20:20:49.367647+00	37	development
2	2023-09-15 20:20:49.367647+00	37	production
2	2023-09-15 20:20:49.367647+00	37	default
2	2023-09-15 20:20:49.41737+00	42	\N
2	2023-09-15 20:20:49.41737+00	43	\N
2	2023-09-15 20:20:49.41737+00	44	\N
4	2023-09-15 20:20:49.421272+00	42	\N
4	2023-09-15 20:20:49.421272+00	43	\N
4	2023-09-15 20:20:49.421272+00	44	\N
5	2023-09-15 20:20:49.425589+00	42	\N
5	2023-09-15 20:20:49.425589+00	43	\N
5	2023-09-15 20:20:49.425589+00	44	\N
2	2023-09-15 20:20:49.542211+00	53	\N
2	2023-09-15 20:20:49.542211+00	57	\N
\.


--
-- Data for Name: role_user; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.role_user (role_id, user_id, created_at, project) FROM stdin;
1	1	2023-09-15 20:20:50.056432+00	default
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.roles (id, name, description, type, created_at, updated_at) FROM stdin;
1	Admin	Users with the root admin role have superuser access to Unleash and can perform any operation within the Unleash platform.	root	2023-09-15 20:20:48.667186+00	\N
2	Editor	Users with the root editor role have access to most features in Unleash, but can not manage users and roles in the root scope. Editors will be added as project owners when creating projects and get superuser rights within the context of these projects. Users with the editor role will also get access to most permissions on the default project by default.	root	2023-09-15 20:20:48.667186+00	\N
3	Viewer	Users with the root viewer role can only read root resources in Unleash. Viewers can be added to specific projects as project members. Users with the viewer role may not view API tokens.	root	2023-09-15 20:20:48.667186+00	\N
4	Owner	Users with the project owner role have full control over the project, and can add and manage other users within the project context, manage feature toggles within the project, and control advanced project features like archiving and deleting the project.	project	2023-09-15 20:20:48.798413+00	\N
5	Member	Users with the project member role are allowed to view, create, and update feature toggles within a project, but have limited permissions in regards to managing the project's user access and can not archive or delete the project.	project	2023-09-15 20:20:48.798413+00	\N
\.


--
-- Data for Name: segments; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.segments (id, name, description, created_by, created_at, constraints, segment_project_id) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.settings (name, content) FROM stdin;
unleash.secret	"4644b6d850c4458d061d01671c8483ad470b2b92"
instanceInfo	{"id" : "f997e089-6bb0-42a1-ad00-8fd9c9b7c764"}
login_history_retention	{"hours": 336}
\.


--
-- Data for Name: strategies; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.strategies (created_at, name, description, parameters, built_in, deprecated, sort_order, display_name, title) FROM stdin;
2023-09-15 20:20:48.471601+00	remoteAddress	Enable the feature for a specific set of IP addresses.	[{"name":"IPs","type":"list","description":"List of IPs to enable the feature toggle for.","required":true}]	1	f	3	IPs	\N
2023-09-15 20:20:48.471601+00	applicationHostname	Enable the feature for a specific set of hostnames.	[{"name":"hostNames","type":"list","description":"List of hostnames to enable the feature toggle for.","required":false}]	1	f	4	Hosts	\N
2023-09-15 20:20:48.410062+00	default	This strategy turns on / off for your entire userbase. Prefer using "Gradual rollout" strategy (100%=on, 0%=off).	[]	1	f	1	Standard	\N
2023-09-15 20:20:48.528953+00	flexibleRollout	Roll out to a percentage of your userbase, and ensure that the experience is the same for the user on each visit.	[{"name":"rollout","type":"percentage","description":"","required":false},{"name":"stickiness","type":"string","description":"Used define stickiness. Possible values: default, userId, sessionId, random","required":true},{"name":"groupId","type":"string","description":"Used to define a activation groups, which allows you to correlate across feature toggles.","required":true}]	1	f	0	Gradual rollout	\N
2023-09-15 20:20:48.471601+00	userWithId	Enable the feature for a specific set of userIds. Prefer using "Gradual rollout" strategy with user id constraints.	[{"name":"userIds","type":"list","description":"","required":false}]	1	t	2	UserIDs	\N
\.


--
-- Data for Name: tag_types; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.tag_types (name, description, icon, created_at) FROM stdin;
simple	Used to simplify filtering of features	#	2023-09-15 20:20:48.614568+00
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.tags (type, value, created_at) FROM stdin;
\.


--
-- Data for Name: unleash_session; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.unleash_session (sid, sess, created_at, expired) FROM stdin;
IOnDzwUH5XQgrBC1UQRywuTuY9ZuL2Up	{"cookie":{"originalMaxAge":172800000,"expires":"2023-09-17T20:20:56.195Z","secure":false,"httpOnly":true,"path":"/","sameSite":"lax"},"user":{"isAPI":false,"accountType":"User","id":1,"username":"admin","imageUrl":"https://gravatar.com/avatar/21232f297a57a5a743894a0e4a801fc3?size=42&default=retro","seenAt":null,"loginAttempts":0,"createdAt":"2023-09-15T20:20:49.867Z"}}	2023-09-15 20:20:56.198319+00	2023-09-17 20:30:11.963+00
\.


--
-- Data for Name: user_feedback; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.user_feedback (user_id, feedback_id, given, nevershow) FROM stdin;
\.


--
-- Data for Name: user_notifications; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.user_notifications (notification_id, user_id, read_at) FROM stdin;
\.


--
-- Data for Name: user_splash; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.user_splash (user_id, splash_id, seen) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: smarttesting
--

COPY public.users (id, name, username, email, image_url, password_hash, login_attempts, created_at, seen_at, settings, permissions, deleted_at, is_service) FROM stdin;
1	\N	admin	\N	\N	$2a$10$PYMLjBy1109ctX9b3TZiqOschdycne52arI3cI77yrm6vkTdLa1bC	0	2023-09-15 20:20:49.867429	2023-09-15 20:20:56.186	\N	[]	\N	f
\.


--
-- Name: addons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.addons_id_seq', 1, false);


--
-- Name: change_request_approvals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.change_request_approvals_id_seq', 1, false);


--
-- Name: change_request_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.change_request_comments_id_seq', 1, false);


--
-- Name: change_request_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.change_request_events_id_seq', 1, false);


--
-- Name: change_request_rejections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.change_request_rejections_id_seq', 1, false);


--
-- Name: change_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.change_requests_id_seq', 1, false);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.events_id_seq', 13, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, false);


--
-- Name: login_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.login_events_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.migrations_id_seq', 198, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.permissions_id_seq', 57, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.roles_id_seq', 5, true);


--
-- Name: segments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.segments_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smarttesting
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: addons addons_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.addons
    ADD CONSTRAINT addons_pkey PRIMARY KEY (id);


--
-- Name: api_tokens api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_tokens_pkey PRIMARY KEY (secret);


--
-- Name: change_request_approvals change_request_approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_approvals
    ADD CONSTRAINT change_request_approvals_pkey PRIMARY KEY (id);


--
-- Name: change_request_comments change_request_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_comments
    ADD CONSTRAINT change_request_comments_pkey PRIMARY KEY (id);


--
-- Name: change_request_events change_request_events_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_events
    ADD CONSTRAINT change_request_events_pkey PRIMARY KEY (id);


--
-- Name: change_request_rejections change_request_rejections_change_request_id_created_by_key; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_rejections
    ADD CONSTRAINT change_request_rejections_change_request_id_created_by_key UNIQUE (change_request_id, created_by);


--
-- Name: change_request_rejections change_request_rejections_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_rejections
    ADD CONSTRAINT change_request_rejections_pkey PRIMARY KEY (id);


--
-- Name: change_request_settings change_request_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_settings
    ADD CONSTRAINT change_request_settings_pkey PRIMARY KEY (project, environment);


--
-- Name: change_request_settings change_request_settings_project_environment_key; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_settings
    ADD CONSTRAINT change_request_settings_project_environment_key UNIQUE (project, environment);


--
-- Name: change_requests change_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT change_requests_pkey PRIMARY KEY (id);


--
-- Name: client_applications client_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.client_applications
    ADD CONSTRAINT client_applications_pkey PRIMARY KEY (app_name);


--
-- Name: client_applications_usage client_applications_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.client_applications_usage
    ADD CONSTRAINT client_applications_usage_pkey PRIMARY KEY (app_name, project, environment);


--
-- Name: client_instances client_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.client_instances
    ADD CONSTRAINT client_instances_pkey PRIMARY KEY (app_name, environment, instance_id);


--
-- Name: client_metrics_env client_metrics_env_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.client_metrics_env
    ADD CONSTRAINT client_metrics_env_pkey PRIMARY KEY (feature_name, app_name, environment, "timestamp");


--
-- Name: client_metrics_env_variants client_metrics_env_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.client_metrics_env_variants
    ADD CONSTRAINT client_metrics_env_variants_pkey PRIMARY KEY (feature_name, app_name, environment, "timestamp", variant);


--
-- Name: context_fields context_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.context_fields
    ADD CONSTRAINT context_fields_pkey PRIMARY KEY (name);


--
-- Name: environments environments_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.environments
    ADD CONSTRAINT environments_pkey PRIMARY KEY (name);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: favorite_features favorite_features_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.favorite_features
    ADD CONSTRAINT favorite_features_pkey PRIMARY KEY (feature, user_id);


--
-- Name: favorite_projects favorite_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.favorite_projects
    ADD CONSTRAINT favorite_projects_pkey PRIMARY KEY (project, user_id);


--
-- Name: feature_environments feature_environments_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_environments
    ADD CONSTRAINT feature_environments_pkey PRIMARY KEY (environment, feature_name);


--
-- Name: feature_strategies feature_strategies_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_strategies
    ADD CONSTRAINT feature_strategies_pkey PRIMARY KEY (id);


--
-- Name: feature_strategy_segment feature_strategy_segment_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_strategy_segment
    ADD CONSTRAINT feature_strategy_segment_pkey PRIMARY KEY (feature_strategy_id, segment_id);


--
-- Name: feature_tag feature_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_tag
    ADD CONSTRAINT feature_tag_pkey PRIMARY KEY (feature_name, tag_type, tag_value);


--
-- Name: feature_types feature_types_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_types
    ADD CONSTRAINT feature_types_pkey PRIMARY KEY (id);


--
-- Name: features features_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (name);


--
-- Name: group_role group_role_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.group_role
    ADD CONSTRAINT group_role_pkey PRIMARY KEY (group_id, role_id, project);


--
-- Name: group_user group_user_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.group_user
    ADD CONSTRAINT group_user_pkey PRIMARY KEY (group_id, user_id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: login_history login_events_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.login_history
    ADD CONSTRAINT login_events_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: project_environments project_environments_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.project_environments
    ADD CONSTRAINT project_environments_pkey PRIMARY KEY (project_id, environment_name);


--
-- Name: project_settings project_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.project_settings
    ADD CONSTRAINT project_settings_pkey PRIMARY KEY (project);


--
-- Name: project_stats project_stats_project_key; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.project_stats
    ADD CONSTRAINT project_stats_project_key UNIQUE (project);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: public_signup_tokens public_signup_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.public_signup_tokens
    ADD CONSTRAINT public_signup_tokens_pkey PRIMARY KEY (secret);


--
-- Name: public_signup_tokens_user public_signup_tokens_user_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.public_signup_tokens_user
    ADD CONSTRAINT public_signup_tokens_user_pkey PRIMARY KEY (secret, user_id);


--
-- Name: reset_tokens reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.reset_tokens
    ADD CONSTRAINT reset_tokens_pkey PRIMARY KEY (reset_token);


--
-- Name: role_user role_user_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.role_user
    ADD CONSTRAINT role_user_pkey PRIMARY KEY (role_id, user_id, project);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: segments segments_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (name);


--
-- Name: strategies strategies_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.strategies
    ADD CONSTRAINT strategies_pkey PRIMARY KEY (name);


--
-- Name: tag_types tag_types_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.tag_types
    ADD CONSTRAINT tag_types_pkey PRIMARY KEY (name);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (type, value);


--
-- Name: change_request_approvals unique_approvals; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_approvals
    ADD CONSTRAINT unique_approvals UNIQUE (change_request_id, created_by);


--
-- Name: roles unique_name; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT unique_name UNIQUE (name);


--
-- Name: unleash_session unleash_session_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.unleash_session
    ADD CONSTRAINT unleash_session_pkey PRIMARY KEY (sid);


--
-- Name: user_feedback user_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.user_feedback
    ADD CONSTRAINT user_feedback_pkey PRIMARY KEY (user_id, feedback_id);


--
-- Name: user_notifications user_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.user_notifications
    ADD CONSTRAINT user_notifications_pkey PRIMARY KEY (notification_id, user_id);


--
-- Name: user_splash user_splash_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.user_splash
    ADD CONSTRAINT user_splash_pkey PRIMARY KEY (user_id, splash_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: client_instances_environment_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX client_instances_environment_idx ON public.client_instances USING btree (environment);


--
-- Name: events_environment_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX events_environment_idx ON public.events USING btree (environment);


--
-- Name: events_project_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX events_project_idx ON public.events USING btree (project);


--
-- Name: feature_environments_feature_name_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX feature_environments_feature_name_idx ON public.feature_environments USING btree (feature_name);


--
-- Name: feature_name_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX feature_name_idx ON public.events USING btree (feature_name);


--
-- Name: feature_strategies_environment_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX feature_strategies_environment_idx ON public.feature_strategies USING btree (environment);


--
-- Name: feature_strategies_feature_name_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX feature_strategies_feature_name_idx ON public.feature_strategies USING btree (feature_name);


--
-- Name: feature_strategy_segment_segment_id_index; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX feature_strategy_segment_segment_id_index ON public.feature_strategy_segment USING btree (segment_id);


--
-- Name: feature_tag_tag_type_and_value_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX feature_tag_tag_type_and_value_idx ON public.feature_tag USING btree (tag_type, tag_value);


--
-- Name: idx_client_metrics_f_name; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX idx_client_metrics_f_name ON public.client_metrics_env USING btree (feature_name);


--
-- Name: idx_unleash_session_expired; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX idx_unleash_session_expired ON public.unleash_session USING btree (expired);


--
-- Name: login_events_ip_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX login_events_ip_idx ON public.login_history USING btree (ip);


--
-- Name: project_environments_environment_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX project_environments_environment_idx ON public.project_environments USING btree (environment_name);


--
-- Name: reset_tokens_user_id_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX reset_tokens_user_id_idx ON public.reset_tokens USING btree (user_id);


--
-- Name: role_permission_role_id_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX role_permission_role_id_idx ON public.role_permission USING btree (role_id);


--
-- Name: role_user_user_id_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX role_user_user_id_idx ON public.role_user USING btree (user_id);


--
-- Name: segments_name_index; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX segments_name_index ON public.segments USING btree (name);


--
-- Name: user_feedback_user_id_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX user_feedback_user_id_idx ON public.user_feedback USING btree (user_id);


--
-- Name: user_splash_user_id_idx; Type: INDEX; Schema: public; Owner: smarttesting
--

CREATE INDEX user_splash_user_id_idx ON public.user_splash USING btree (user_id);


--
-- Name: api_token_project api_token_project_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.api_token_project
    ADD CONSTRAINT api_token_project_project_fkey FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: api_token_project api_token_project_secret_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.api_token_project
    ADD CONSTRAINT api_token_project_secret_fkey FOREIGN KEY (secret) REFERENCES public.api_tokens(secret) ON DELETE CASCADE;


--
-- Name: change_request_approvals change_request_approvals_change_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_approvals
    ADD CONSTRAINT change_request_approvals_change_request_id_fkey FOREIGN KEY (change_request_id) REFERENCES public.change_requests(id) ON DELETE CASCADE;


--
-- Name: change_request_approvals change_request_approvals_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_approvals
    ADD CONSTRAINT change_request_approvals_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: change_request_comments change_request_comments_change_request_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_comments
    ADD CONSTRAINT change_request_comments_change_request_fkey FOREIGN KEY (change_request) REFERENCES public.change_requests(id) ON DELETE CASCADE;


--
-- Name: change_request_comments change_request_comments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_comments
    ADD CONSTRAINT change_request_comments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: change_request_events change_request_events_change_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_events
    ADD CONSTRAINT change_request_events_change_request_id_fkey FOREIGN KEY (change_request_id) REFERENCES public.change_requests(id) ON DELETE CASCADE;


--
-- Name: change_request_events change_request_events_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_events
    ADD CONSTRAINT change_request_events_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: change_request_events change_request_events_feature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_events
    ADD CONSTRAINT change_request_events_feature_fkey FOREIGN KEY (feature) REFERENCES public.features(name) ON DELETE CASCADE;


--
-- Name: change_request_rejections change_request_rejections_change_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_rejections
    ADD CONSTRAINT change_request_rejections_change_request_id_fkey FOREIGN KEY (change_request_id) REFERENCES public.change_requests(id) ON DELETE CASCADE;


--
-- Name: change_request_rejections change_request_rejections_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_rejections
    ADD CONSTRAINT change_request_rejections_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: change_request_settings change_request_settings_environment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_settings
    ADD CONSTRAINT change_request_settings_environment_fkey FOREIGN KEY (environment) REFERENCES public.environments(name) ON DELETE CASCADE;


--
-- Name: change_request_settings change_request_settings_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_request_settings
    ADD CONSTRAINT change_request_settings_project_fkey FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: change_requests change_requests_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT change_requests_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: change_requests change_requests_environment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT change_requests_environment_fkey FOREIGN KEY (environment) REFERENCES public.environments(name) ON DELETE CASCADE;


--
-- Name: change_requests change_requests_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.change_requests
    ADD CONSTRAINT change_requests_project_fkey FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: client_applications_usage client_applications_usage_app_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.client_applications_usage
    ADD CONSTRAINT client_applications_usage_app_name_fkey FOREIGN KEY (app_name) REFERENCES public.client_applications(app_name) ON DELETE CASCADE;


--
-- Name: client_metrics_env_variants client_metrics_env_variants_feature_name_app_name_environm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.client_metrics_env_variants
    ADD CONSTRAINT client_metrics_env_variants_feature_name_app_name_environm_fkey FOREIGN KEY (feature_name, app_name, environment, "timestamp") REFERENCES public.client_metrics_env(feature_name, app_name, environment, "timestamp") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: favorite_features favorite_features_feature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.favorite_features
    ADD CONSTRAINT favorite_features_feature_fkey FOREIGN KEY (feature) REFERENCES public.features(name) ON DELETE CASCADE;


--
-- Name: favorite_features favorite_features_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.favorite_features
    ADD CONSTRAINT favorite_features_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorite_projects favorite_projects_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.favorite_projects
    ADD CONSTRAINT favorite_projects_project_fkey FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: favorite_projects favorite_projects_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.favorite_projects
    ADD CONSTRAINT favorite_projects_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: feature_environments feature_environments_environment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_environments
    ADD CONSTRAINT feature_environments_environment_fkey FOREIGN KEY (environment) REFERENCES public.environments(name) ON DELETE CASCADE;


--
-- Name: feature_environments feature_environments_feature_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_environments
    ADD CONSTRAINT feature_environments_feature_name_fkey FOREIGN KEY (feature_name) REFERENCES public.features(name) ON DELETE CASCADE;


--
-- Name: feature_strategies feature_strategies_environment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_strategies
    ADD CONSTRAINT feature_strategies_environment_fkey FOREIGN KEY (environment) REFERENCES public.environments(name) ON DELETE CASCADE;


--
-- Name: feature_strategies feature_strategies_feature_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_strategies
    ADD CONSTRAINT feature_strategies_feature_name_fkey FOREIGN KEY (feature_name) REFERENCES public.features(name) ON DELETE CASCADE;


--
-- Name: feature_strategy_segment feature_strategy_segment_feature_strategy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_strategy_segment
    ADD CONSTRAINT feature_strategy_segment_feature_strategy_id_fkey FOREIGN KEY (feature_strategy_id) REFERENCES public.feature_strategies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feature_strategy_segment feature_strategy_segment_segment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_strategy_segment
    ADD CONSTRAINT feature_strategy_segment_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES public.segments(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feature_tag feature_tag_feature_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_tag
    ADD CONSTRAINT feature_tag_feature_name_fkey FOREIGN KEY (feature_name) REFERENCES public.features(name) ON DELETE CASCADE;


--
-- Name: feature_tag feature_tag_tag_type_tag_value_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.feature_tag
    ADD CONSTRAINT feature_tag_tag_type_tag_value_fkey FOREIGN KEY (tag_type, tag_value) REFERENCES public.tags(type, value) ON DELETE CASCADE;


--
-- Name: groups fk_group_role_id; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_group_role_id FOREIGN KEY (root_role_id) REFERENCES public.roles(id);


--
-- Name: group_role fk_group_role_project; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.group_role
    ADD CONSTRAINT fk_group_role_project FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: group_role group_role_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.group_role
    ADD CONSTRAINT group_role_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: group_role group_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.group_role
    ADD CONSTRAINT group_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: group_user group_user_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.group_user
    ADD CONSTRAINT group_user_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: group_user group_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.group_user
    ADD CONSTRAINT group_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: personal_access_tokens personal_access_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: project_environments project_environments_environment_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.project_environments
    ADD CONSTRAINT project_environments_environment_name_fkey FOREIGN KEY (environment_name) REFERENCES public.environments(name) ON DELETE CASCADE;


--
-- Name: project_environments project_environments_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.project_environments
    ADD CONSTRAINT project_environments_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: project_settings project_settings_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.project_settings
    ADD CONSTRAINT project_settings_project_fkey FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: project_stats project_stats_project_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.project_stats
    ADD CONSTRAINT project_stats_project_fkey FOREIGN KEY (project) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: public_signup_tokens public_signup_tokens_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.public_signup_tokens
    ADD CONSTRAINT public_signup_tokens_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: public_signup_tokens_user public_signup_tokens_user_secret_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.public_signup_tokens_user
    ADD CONSTRAINT public_signup_tokens_user_secret_fkey FOREIGN KEY (secret) REFERENCES public.public_signup_tokens(secret) ON DELETE CASCADE;


--
-- Name: public_signup_tokens_user public_signup_tokens_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.public_signup_tokens_user
    ADD CONSTRAINT public_signup_tokens_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reset_tokens reset_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.reset_tokens
    ADD CONSTRAINT reset_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: role_permission role_permission_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: role_user role_user_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.role_user
    ADD CONSTRAINT role_user_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: role_user role_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.role_user
    ADD CONSTRAINT role_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: segments segments_segment_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_segment_project_id_fkey FOREIGN KEY (segment_project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: tags tags_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_type_fkey FOREIGN KEY (type) REFERENCES public.tag_types(name) ON DELETE CASCADE;


--
-- Name: user_feedback user_feedback_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.user_feedback
    ADD CONSTRAINT user_feedback_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_notifications user_notifications_notification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.user_notifications
    ADD CONSTRAINT user_notifications_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES public.notifications(id) ON DELETE CASCADE;


--
-- Name: user_notifications user_notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.user_notifications
    ADD CONSTRAINT user_notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_splash user_splash_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: smarttesting
--

ALTER TABLE ONLY public.user_splash
    ADD CONSTRAINT user_splash_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

