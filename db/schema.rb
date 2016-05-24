# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151017211613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "challenges", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "hashtag"
    t.string   "slug"
    t.string   "video_url"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "background"
    t.text     "outcome"
    t.text     "help"
    t.string   "image"
    t.datetime "starts_at"
    t.string   "active_stage"
    t.string   "headline"
    t.text     "incentive"
    t.string   "cta"
    t.string   "banner"
    t.boolean  "featured"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.integer  "user_id",                                 null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.boolean  "reported",                default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "embed"
    t.text     "link"
    t.integer  "temporal_parent_id"
    t.datetime "destroyed_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.boolean  "featured",                default: false
  end

  add_index "comments", ["cached_votes_down"], name: "index_comments_on_cached_votes_down", using: :btree
  add_index "comments", ["cached_votes_score"], name: "index_comments_on_cached_votes_score", using: :btree
  add_index "comments", ["cached_votes_total"], name: "index_comments_on_cached_votes_total", using: :btree
  add_index "comments", ["cached_votes_up"], name: "index_comments_on_cached_votes_up", using: :btree
  add_index "comments", ["cached_weighted_average"], name: "index_comments_on_cached_weighted_average", using: :btree
  add_index "comments", ["cached_weighted_score"], name: "index_comments_on_cached_weighted_score", using: :btree
  add_index "comments", ["cached_weighted_total"], name: "index_comments_on_cached_weighted_total", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "cookbooks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "recipe_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",  default: 0
  end

  add_index "cookbooks", ["recipe_stage_id"], name: "index_cookbooks_on_recipe_stage_id", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "lea_id"
    t.string   "fipst"
    t.string   "stid"
    t.string   "name"
    t.string   "phone"
    t.string   "mail_street"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip4"
    t.string   "location_street"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.string   "location_zip4"
    t.string   "_type"
    t.string   "union"
    t.string   "county_number"
    t.string   "county_name"
    t.string   "csa"
    t.string   "cbsa"
    t.string   "metmic"
    t.string   "ulocal"
    t.string   "cdcode"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "bound"
    t.string   "biea"
    t.string   "lowest_grade"
    t.string   "highest_grade"
    t.string   "charter"
    t.string   "number_of_schools"
    t.string   "number_of_students"
    t.string   "number_of_k12s"
    t.string   "number_of_members"
    t.string   "number_of_speceds"
    t.string   "number_of_ells"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["lea_id"], name: "index_districts_on_lea_id", unique: true, using: :btree

  create_table "districts_users", force: :cascade do |t|
    t.integer "district_id"
    t.integer "user_id"
  end

  add_index "districts_users", ["district_id", "user_id"], name: "index_districts_users_on_district_id_and_user_id", using: :btree

  create_table "experience_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "incentive"
  end

  add_index "experience_stages", ["challenge_id"], name: "index_experience_stages_on_challenge_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.text     "link"
    t.boolean  "featured",                default: false
    t.integer  "user_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.text     "embed"
    t.datetime "destroyed_at"
    t.datetime "published_at"
    t.integer  "comments_count",          default: 0
  end

  add_index "experiences", ["cached_votes_down"], name: "index_experiences_on_cached_votes_down", using: :btree
  add_index "experiences", ["cached_votes_score"], name: "index_experiences_on_cached_votes_score", using: :btree
  add_index "experiences", ["cached_votes_total"], name: "index_experiences_on_cached_votes_total", using: :btree
  add_index "experiences", ["cached_votes_up"], name: "index_experiences_on_cached_votes_up", using: :btree
  add_index "experiences", ["cached_weighted_average"], name: "index_experiences_on_cached_weighted_average", using: :btree
  add_index "experiences", ["cached_weighted_score"], name: "index_experiences_on_cached_weighted_score", using: :btree
  add_index "experiences", ["cached_weighted_total"], name: "index_experiences_on_cached_weighted_total", using: :btree
  add_index "experiences", ["user_id", "theme_id"], name: "index_experiences_on_user_id_and_theme_id", using: :btree

  create_table "experiences_solutions", id: false, force: :cascade do |t|
    t.integer "solution_id",   null: false
    t.integer "experience_id", null: false
  end

  add_index "experiences_solutions", ["experience_id"], name: "index_experiences_solutions_on_experience_id", using: :btree
  add_index "experiences_solutions", ["solution_id"], name: "index_experiences_solutions_on_solution_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.text     "reason"
    t.string   "category"
    t.boolean  "active"
    t.integer  "user_id"
    t.integer  "featureable_id"
    t.string   "featureable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "challenge_id",     null: false
  end

  add_index "features", ["challenge_id"], name: "index_features_on_challenge_id", using: :btree
  add_index "features", ["featureable_id", "featureable_type"], name: "index_features_on_featureable_id_and_featureable_type", using: :btree
  add_index "features", ["user_id"], name: "index_features_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "idea_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "incentive"
  end

  add_index "idea_stages", ["challenge_id"], name: "index_idea_stages_on_challenge_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.string   "image"
    t.string   "file"
    t.text     "embed"
    t.integer  "problem_statement_id"
    t.integer  "user_id"
    t.integer  "refinement_parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "destroyed_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.text     "impact"
    t.text     "implementation"
    t.datetime "published_at"
    t.integer  "comments_count",          default: 0
    t.boolean  "inspiration",             default: false
    t.boolean  "featured",                default: false
  end

  add_index "ideas", ["cached_votes_down"], name: "index_ideas_on_cached_votes_down", using: :btree
  add_index "ideas", ["cached_votes_score"], name: "index_ideas_on_cached_votes_score", using: :btree
  add_index "ideas", ["cached_votes_total"], name: "index_ideas_on_cached_votes_total", using: :btree
  add_index "ideas", ["cached_votes_up"], name: "index_ideas_on_cached_votes_up", using: :btree
  add_index "ideas", ["cached_weighted_average"], name: "index_ideas_on_cached_weighted_average", using: :btree
  add_index "ideas", ["cached_weighted_score"], name: "index_ideas_on_cached_weighted_score", using: :btree
  add_index "ideas", ["cached_weighted_total"], name: "index_ideas_on_cached_weighted_total", using: :btree
  add_index "ideas", ["refinement_parent_id"], name: "index_ideas_on_refinement_parent_id", using: :btree
  add_index "ideas", ["user_id", "problem_statement_id"], name: "index_ideas_on_user_id_and_problem_statement_id", using: :btree

  create_table "ideas_solutions", id: false, force: :cascade do |t|
    t.integer "solution_id", null: false
    t.integer "idea_id",     null: false
  end

  add_index "ideas_solutions", ["idea_id"], name: "index_ideas_solutions_on_idea_id", using: :btree
  add_index "ideas_solutions", ["solution_id"], name: "index_ideas_solutions_on_solution_id", using: :btree

  create_table "mailkick_opt_outs", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_id"
    t.string   "user_type"
    t.boolean  "active",     default: true, null: false
    t.string   "reason"
    t.string   "list"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mailkick_opt_outs", ["email"], name: "index_mailkick_opt_outs_on_email", using: :btree
  add_index "mailkick_opt_outs", ["user_id", "user_type"], name: "index_mailkick_opt_outs_on_user_id_and_user_type", using: :btree

  create_table "panels", force: :cascade do |t|
    t.text     "about"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "panels", ["challenge_id"], name: "index_panels_on_challenge_id", unique: true, using: :btree

  create_table "panels_users", id: false, force: :cascade do |t|
    t.integer "panel_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "panels_users", ["panel_id"], name: "index_panels_users_on_panel_id", using: :btree
  add_index "panels_users", ["user_id"], name: "index_panels_users_on_user_id", using: :btree

  create_table "problem_statements", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "idea_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "problem_statements", ["idea_stage_id"], name: "index_problem_statements_on_idea_stage_id", using: :btree

  create_table "recipe_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "incentive"
    t.text     "title_instructions",       default: "Add a Title"
    t.text     "description_instructions", default: "Describe your recipe. What are the goals? What are the challenges? Why does this recipe matter?"
    t.text     "steps_instructions",       default: "Outline how to implement this recipe step by step."
    t.text     "materials_instructions",   default: "What equipment or supplies are needed?"
    t.text     "community_instructions",   default: "Every good recipe provides the number of servings. How many people need to participate and who are they?"
    t.text     "conditions_instructions",  default: "What needs to be true of the culture or environment to try out this recipe?"
    t.text     "evidence_instructions",    default: "What evidence can we collect to know when we’re on the right track?"
    t.text     "protips_instructions",     default: "What advice can you offer to make the experience of trying out your recipe as smooth as possible?  Is there anything you can identify as a possible stumbling block? Things to keep in mind?"
  end

  add_index "recipe_stages", ["challenge_id"], name: "index_recipe_stages_on_challenge_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "materials"
    t.text     "link"
    t.string   "image"
    t.text     "file"
    t.text     "embed"
    t.datetime "destroyed_at"
    t.integer  "cookbook_id"
    t.integer  "user_id"
    t.integer  "refinement_parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.datetime "published_at"
    t.integer  "comments_count",          default: 0
    t.boolean  "featured",                default: false
    t.text     "community"
    t.text     "conditions"
    t.text     "evidence"
    t.text     "protips"
  end

  add_index "recipes", ["cached_votes_down"], name: "index_recipes_on_cached_votes_down", using: :btree
  add_index "recipes", ["cached_votes_score"], name: "index_recipes_on_cached_votes_score", using: :btree
  add_index "recipes", ["cached_votes_total"], name: "index_recipes_on_cached_votes_total", using: :btree
  add_index "recipes", ["cached_votes_up"], name: "index_recipes_on_cached_votes_up", using: :btree
  add_index "recipes", ["cached_weighted_average"], name: "index_recipes_on_cached_weighted_average", using: :btree
  add_index "recipes", ["cached_weighted_score"], name: "index_recipes_on_cached_weighted_score", using: :btree
  add_index "recipes", ["cached_weighted_total"], name: "index_recipes_on_cached_weighted_total", using: :btree
  add_index "recipes", ["user_id", "cookbook_id"], name: "index_recipes_on_user_id_and_cookbook_id", using: :btree

  create_table "recipes_solutions", id: false, force: :cascade do |t|
    t.integer "solution_id", null: false
    t.integer "recipe_id",   null: false
  end

  add_index "recipes_solutions", ["recipe_id"], name: "index_recipes_solutions_on_recipe_id", using: :btree
  add_index "recipes_solutions", ["solution_id"], name: "index_recipes_solutions_on_solution_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "nces_id"
    t.string   "fipst"
    t.string   "lea_id"
    t.string   "school_id"
    t.string   "stid"
    t.string   "sea_school_id"
    t.string   "lea_name"
    t.string   "name"
    t.string   "phone"
    t.string   "mail_street"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip4"
    t.string   "location_street"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.string   "location_zip4"
    t.string   "_type"
    t.string   "status"
    t.string   "ulocal"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "county_number"
    t.string   "county_name"
    t.string   "cdcode"
    t.string   "ft_teachers"
    t.string   "lowest_grade"
    t.string   "highest_grade"
    t.string   "level"
    t.string   "title1"
    t.string   "stitle1"
    t.string   "magnet"
    t.string   "charter"
    t.string   "shared"
    t.string   "bies"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["nces_id"], name: "index_schools_on_nces_id", unique: true, using: :btree

  create_table "schools_users", force: :cascade do |t|
    t.integer "school_id"
    t.integer "user_id"
  end

  add_index "schools_users", ["school_id", "user_id"], name: "index_schools_users_on_school_id_and_user_id", using: :btree

  create_table "solution_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solution_stages", ["challenge_id"], name: "index_solution_stages_on_challenge_id", using: :btree

  create_table "solution_stories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.text     "embed"
    t.string   "image"
    t.datetime "destroyed_at"
    t.integer  "solution_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "solution_stories", ["solution_stage_id"], name: "index_solution_stories_on_solution_stage_id", using: :btree

  create_table "solutions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "materials"
    t.string   "effort"
    t.text     "link"
    t.text     "embed"
    t.string   "image"
    t.string   "file"
    t.datetime "destroyed_at"
    t.integer  "solution_story_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.datetime "published_at"
    t.integer  "comments_count",          default: 0
    t.boolean  "featured",                default: false
    t.text     "community"
    t.text     "conditions"
    t.text     "evidence"
    t.text     "protips"
  end

  add_index "solutions", ["cached_votes_down"], name: "index_solutions_on_cached_votes_down", using: :btree
  add_index "solutions", ["cached_votes_score"], name: "index_solutions_on_cached_votes_score", using: :btree
  add_index "solutions", ["cached_votes_total"], name: "index_solutions_on_cached_votes_total", using: :btree
  add_index "solutions", ["cached_votes_up"], name: "index_solutions_on_cached_votes_up", using: :btree
  add_index "solutions", ["cached_weighted_average"], name: "index_solutions_on_cached_weighted_average", using: :btree
  add_index "solutions", ["cached_weighted_score"], name: "index_solutions_on_cached_weighted_score", using: :btree
  add_index "solutions", ["cached_weighted_total"], name: "index_solutions_on_cached_weighted_total", using: :btree
  add_index "solutions", ["user_id", "solution_story_id"], name: "index_solutions_on_user_id_and_solution_story_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "fipst"
    t.string   "name"
    t.string   "mail_street"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip4"
    t.string   "phone"
    t.string   "number_of_members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["fipst"], name: "index_states_on_fipst", unique: true, using: :btree

  create_table "states_users", force: :cascade do |t|
    t.integer "state_id"
    t.integer "user_id"
  end

  add_index "states_users", ["state_id", "user_id"], name: "index_states_users_on_state_id_and_user_id", using: :btree

  create_table "steps", force: :cascade do |t|
    t.integer  "display_order"
    t.string   "title"
    t.text     "description"
    t.integer  "steppable_id"
    t.string   "steppable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steps", ["steppable_id", "steppable_type"], name: "index_steps_on_steppable_id_and_steppable_type", using: :btree

  create_table "suggestions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.text     "embed"
    t.string   "image"
    t.datetime "destroyed_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "suggestions", ["cached_votes_down"], name: "index_suggestions_on_cached_votes_down", using: :btree
  add_index "suggestions", ["cached_votes_score"], name: "index_suggestions_on_cached_votes_score", using: :btree
  add_index "suggestions", ["cached_votes_total"], name: "index_suggestions_on_cached_votes_total", using: :btree
  add_index "suggestions", ["cached_votes_up"], name: "index_suggestions_on_cached_votes_up", using: :btree
  add_index "suggestions", ["cached_weighted_average"], name: "index_suggestions_on_cached_weighted_average", using: :btree
  add_index "suggestions", ["cached_weighted_score"], name: "index_suggestions_on_cached_weighted_score", using: :btree
  add_index "suggestions", ["cached_weighted_total"], name: "index_suggestions_on_cached_weighted_total", using: :btree
  add_index "suggestions", ["user_id"], name: "index_suggestions_on_user_id", using: :btree

  create_table "themes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "experience_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "themes", ["experience_stage_id"], name: "index_themes_on_experience_stage_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                                                                                null: false
    t.string   "encrypted_password",     default: "",                                                                                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                                                                 null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.string   "organization"
    t.boolean  "admin",                  default: false
    t.string   "ga_dimension"
    t.string   "title"
    t.boolean  "video_access",           default: false
    t.string   "twitter"
    t.string   "avatar"
    t.boolean  "future_participant",     default: true
    t.string   "color"
    t.text     "bio"
    t.integer  "referrer_id"
    t.string   "display_name"
    t.string   "avatar_option",          default: "twitter"
    t.hstore   "notifications",          default: {"comment_posted"=>"true", "comment_replied"=>"true", "comment_followed"=>"true"}
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["referrer_id"], name: "index_users_on_referrer_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
