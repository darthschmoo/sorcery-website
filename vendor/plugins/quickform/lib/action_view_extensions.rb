module ActionViewExtensions
  module Helpers
    module FormHelper
      def quick_form_for( record, options = {}, &block )
        options[:html] ||= {}
        if options[:html][:class].blank?
          options[:html][:class] = "decorated"
        else
          options[:html][:class] += " decorated"
        end
        
        form_for( record, options, &block )
      end
      
      def quick_text_field( object_name, method, options = {} )
        quick_form_element_common( self.text_field( object_name, method, options ), object_name, method, options )
      end
      
      def quick_password_field( object_name, method, options = {} )
        quick_form_element_common( self.password_field( object_name, method, options ), object_name, method, options )
      end
      
      def quick_text_area( object_name, method, options = {} )
        options.reverse_merge!( { :rows => 5, :cols => 30 }) # default size
        quick_form_element_common( self.text_area( object_name, method, options ), object_name, method, options )
      end
      
      def quick_check_box( description, object_name, method, options = {}, checked_value = "1", unchecked_value = "0" )
        explanation = options.delete(:explanation)
        content_tag( :div, :class => "#{object_name}__#{method} for_check_box" ) do
          self.check_box(object_name, method, options, checked_value, unchecked_value ) + 
            content_tag( :p, description ) + 
            explanation_button( explanation )
        end
      end
      
      def quick_collection_select( object_name, method, collection, value_method, text_method, options = {}, html_options = {} ) 
        content = self.collection_select( object_name, method, collection, value_method, text_method, options, html_options )
        quick_form_element_common( content, object_name, method, options )
      end
      
      def quick_form_element_common( content, object_name, method, options = {} )
        content_tag( :div, :class => "#{object_name}__#{method}" ) do
          explanation = options.delete(:explanation)
          label_text = options.delete(:label) || "#{method}"
          label_options = options.delete(:label_options) || {}
          label( object_name, method, "#{label_text.humanize}:", label_options ) + explanation_button( explanation ) + content
        end        
      end
      
      def explanation_button( text )
        return "" if text.blank?
        
        id = "explanation_#{rand(100000000)}"
        
        content_tag( :a, image_tag("question_mark.png"), :class => "explanation_button", :href => "#", 
        :onmouseover => "$('#{id}').appear( { duration : 0.1 } )", 
        :onmouseout => "$('#{id}').fade({ duration : 0.3 })" ) +
        content_tag( :div, :class => "explanation_container" ) do
          content_tag( :p, text, :id => id, :class => "explanation", :style => "display: none" )
        end
      end
      
      def quick_calendar_select( description, object_name, method, options = {} )
        unless options[:embedded] == false
          options[:embedded] = true 
        end
        
        options[:year_range] ||= 3
        
        content_tag( :div ) do
          inner = content_tag( :label ) do
            description
          end
          
          inner << content_tag( :div, :class => "multi_element_container" ) do
            calendar_date_select( object_name, method, options  )
          end
          
          inner
        end
      end
    end
    
    module FormBuilder
      def quick_text_field( method, options = {} )
        @template.quick_text_field( @object_name, method, options.merge(:object => @object) )
      end  
      
      def quick_password_field( method, options = {} )
        @template.quick_password_field( @object_name, method, options.merge(:object => @object) )
      end
      
      def quick_text_area( method, options = {} )
        @template.quick_text_area( @object_name, method, options.merge(:object => @object) )
      end
      
      def quick_check_box( description, method, options = {}, checked_value = "1", unchecked_value = "0" )
        @template.quick_check_box( description, @object_name, method, options, checked_value, unchecked_value )
      end

      def quick_collection_select( method, collection, value_method, text_method, options = {}, html_options = {} ) 
        @template.quick_collection_select( @object_name, method, collection, value_method, text_method, options, html_options )
      end
      
      def quick_calendar_select( description, method, options = {} )
        @template.quick_calendar_select( description, @object_name, method, options  )
      end
    end
    
    module FormOptionsHelper
      def options_from_range_for_select( range, selected = nil)
        options_from_collection_for_select( range.map{ |i| [i] }, :first, :last, selected )
      end
    end
  end
end


class ActionView::Base
  include ActionViewExtensions::Helpers::FormHelper
  include ActionViewExtensions::Helpers::FormOptionsHelper
end

class ActionView::Helpers::FormBuilder
  include ActionViewExtensions::Helpers::FormBuilder
end