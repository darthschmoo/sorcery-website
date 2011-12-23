module CustomAssertions
  def self.included(base)
    base.alias_method_chain :method_missing, :test_for_simple_actions
  end
  
  def method_missing_with_test_for_simple_actions( method_symbol, *args, &block )
    # get_index_succeeds
    # get_index_redirects
    # get_index_redirects_to
    # get_list_succeeds
    # post_index_missing    
    # get_redemption_form_redirects
    # get_your_momma_404s
    match = /^(get|put|post|delete)_([_a-z0-9]+)_(succeeds|redirects|redirects_to|missing|errors|[0-9]+s?)$/.match( method_symbol.to_s )
    
    if match.nil?
      method_missing_without_test_for_simple_actions( *([method_symbol] + args) )
    else
      http_method, action, result = match[1..-1]
      send( http_method.to_sym, *([action] + args) )
      
      case result
      when "succeeds"
        assert_response_success( *args )
      when "redirects"
        assert_response_redirect
      when "redirects_to"
        assert_response_redirect
      when "missing"
        assert_response :missing
      when "errors"
        assert_response :error
      when /[0-9]+s?/     
        assert_response result.gsub( /s$/, "" ).to_i
      end
      
      yield if block_given?
    end
  end

  
  
  # Usage:  get("index"); assert_response_success( :template => "index" )
  def assert_response_success( opts = {} )
    assert_block "@response is nil" do
      !@response.nil?
    end

    if @response.error?
      puts @response.body
    elsif @response.redirect?
      raise Test::Unit::AssertionFailedError.new( "Expected success, was redirect to #{@response.redirected_to} with flash #{flash}" )
    end

    assert_response :success
    assert_template opts[:template] if opts[:template]
  end

  def assert_response_redirect( opts = {} )
    assert_block "@response is nil" do
      !@response.nil?
    end

    if @response.error? || @response.client_error?
      puts @response.body
      puts "Flash:" + @response.flash.map{|k,v| "#{k} : #{v}"}.join(', ')
      debugger
      nil
    elsif @response.success?
      puts "OOPS: should have redirected. Instead went to #{@response.template.action_name}, flash: #{@response.flash.inspect}"
    end

    assert_response :redirect
    assert_redirected_to opts[:to] if opts[:to]
  end

  def assert_no_errors_on( record, message = "" )
    record.valid?
    message = build_message( message,
                             "#{record.class.name} record should have no errors.  Errors: ?",
                             record.errors.map{ |k,v| "[#{k} : #{v}]"}.join(", ")
                             )

    assert_block message do
      record.valid?
    end
  end

  # TODO: Should be able to say which errors should be present
  def assert_errors_on( record, message = "" )
    message = build_message( message, "#{record.class.name} record should have errors.")

    assert_block message do
      !record.valid?
    end
  end
  
  def assert_an_error_on( record, _field, error_says = nil )
    message = build_message( "", "<?> should have an error on the <?> field.", record, _field )
    assert_block message  do
      !record.errors[_field].blank?
    end
    
    unless error_says.blank?
      message = build_message( "", "<?> should have an error on the <?> field that says <?>.", record, _field, error_says )
      assert_block message do
        # puts "Inside field error block"
        #             debugger
        record.errors[_field].include?(error_says)
      end
    end
  end

  def assert_blank( obj, message = "" )
    full_message = build_message(message, "<?> should be blank.", obj)
    assert_block full_message do
      obj.blank?
    end
  end

  def assert_matches( string, regexp_or_string, message = "")
    full_message = build_message(message, "<?> should match regex <?>", string, regexp_or_string)
    assert_block full_message do
      if regexp_or_string.is_a?(Regexp)
        string.match(regexp_or_string) ? true : false
      elsif regexp_or_string.is_a?(String)
        string.include?(regexp_or_string)
      end
    end
  end

  def assert_doesnt_match( string, regexp, message = "")
    full_message = build_message(message, "<?> should not match regex <?>", string, regexp)
    assert_block full_message do
      string.match(regexp) ? false : true
    end
  end

  def assert_record_destroyed( record, message = "")
    not_record_message = build_message(message, "<?> is not an ActiveRecord::Base object.", record)
    new_record_message = build_message(message, "<?> should not be a new record in order to use assert_destroy().", record)
    full_message = build_message(message, "<?> should have been destroyed.", record)

    assert_block not_record_message do
      record.is_a?(ActiveRecord::Base)
    end

    assert_block new_record_message do
      record.new_record? == false
    end

    assert_block full_message do
      record.class.find_by_id(record.id) == nil
    end
  end

  # check that the given variables were assigned non-nil values
  # by the controller

  # If successful, returns an array of assigned objects.
  # You can do:
  # account, phone_number = assert_assigns(:account, :phone_number)
  # or
  # order = assert_assigns(:order)
  def assert_assigns(*args)
    symbols_assigned = []
    symbols_not_assigned = []

    for sym in args
      ((assigns(sym) != nil)? symbols_assigned : symbols_not_assigned) << sym
    end

    message = build_message("", "The following variables should have been assigned values by the controller: <?>", symbols_not_assigned.map{|s| "@#{s.to_s}"}.join(", "))

    assert_block message do
      symbols_not_assigned.length == 0
    end

    if symbols_assigned.length == 1
      assigns(symbols_assigned.first)
    else
      symbols_assigned.map{|s| assigns(s)}
    end
  end

  # read as "assert greater than 5, <test_value>"
  def assert_greater_than( reference_value, amount, message = "" )
    message = build_message("", "second argument <?> should be greater than reference value <?>", amount, reference_value)

    assert_block message do
      amount > reference_value
    end
  end

  # read as "assert less than 5, <test value>"
  def assert_less_than( reference_value, amount, message = "" )
    message = build_message("", "second argument <?> should be less than reference value <?>", amount, reference_value)

    assert_block message do
      amount < reference_value
    end
  end

  def assert_not_zero( actual, message = "" )
    message = build_message(message, "should not be zero")

    assert_block message do
      actual != 0
    end
  end

  def assert_zero( actual, message = "" )
    message = build_message(message, "should be zero, not <#{actual}>")

    assert_block message do
      actual == 0
    end
  end
  
  def assert_one( actual, message = "" )
    message = build_message(message, "should be 1, not <#{actual}>")

    assert_block message do
      actual == 1
    end
  end

  def assert_true( actual, message = "" )
    message = build_message(message, "should be true, not <#{actual}>")
    assert_block message do
      actual == true
    end
  end

  def assert_false( actual, message = "" )
    message = build_message(message, "should be false, not <#{actual}>")
    assert_block message do
      actual == false
    end
  end

  def assert_times_are_close( t1, t2, window = 1, message = "")
    message = build_message(message, "times should be within ? second of each other.", window)

    assert_block message do
      (t1 - t2).abs < window
    end
  end

  def assert_save( record, message = "")
    result = record.save

    message = "Record #{record} did not save properly.  "
    message += record.errors.map{ |k,v| "#{k} : #{v}"}.join(", ")

    assert_block message do
      result
    end
  end

  def assert_equality_of_methods(*args)
    expected = args[0]
    actual = args[1]
    methods = args[2..-1].flatten
    message = "The following methods were not equal: "

    unequal = []

    for method in methods
      exp = expected.send(method.to_sym)
      act = actual.send(method.to_sym)
      unless exp == act
        unequal << method
        message += "\n\t#{method} (#{exp},#{act})"
      end
    end

    assert_block message do
      unequal.blank?
    end
  end
end
