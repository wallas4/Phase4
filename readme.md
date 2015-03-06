# CS 270 - Spring 2015 - QR Code Scavenger Hunt - Phase 2

In this phase, we will tie the Event and Location resources together in
order to take advantage of the association we established previously.
Recall, many Locations could belong to many Events.  It seems reasonable
that in the "edit" page of an Event, to have a listing of available
Locations from which to choose from for that particular event.  Thus, in
this phase we will be dealing with a bit of controller and view
manipulation.

To complete this phase, you need to do the following:

## Event controller

We want to accomplish two main tasks for the Event controller:

First, we want to display a listing of "Available locations", and we
want this listing to appear only on the "edit" page for each individual
Event.

Second, for a particular Event, we want to display a listing of "Event
locations".  We want this listing to appear on both the "show" page and
the "edit" page for a particular Event.

We also want to avoid duplicating Locations in the above lists.  For
example, if a Location 2 is part of Event 1, then Location 2 should not
appear in the "Available locations" listing.  Likewise, if a Location is
not part of an Event, then that Location should not appear in the "Event
locations" listing.

## Edit event page

In the edit event page, we want display "Available locations" for those
Locations not already associated with the Event.  We can access
Locations that are associated with an Event because we have already
established the `has_and_belongs_to_many` relationship between the two
models.  Rails provides some extra methods for the association.  In
particular, we now can reference the associated objects of a different
model with `Model.associated_objects`, which returns to us a Ruby Array.

Thus, because Rails takes care of handling the association for us
internally as an Array, we can modify the `_form.html.erb` file in the
Event view as follows:

```
<p>
  Available locations:

  <table>
    <thead>
      <tr>
        <th>Name</th>
        <th>Tag</th>
        <th colspan="3"></th>
      </tr>
    </thead>

  <% Location.all.each do |location| %>
    <% if ! @event.locations.include? location %>
      <tr>
        <td><%= location.name %></td>
        <td><%= location.tag %></td>
        <td><%= link_to 'Show', location %></td>
        <td><%= link_to 'Edit', edit_location_path(location) %></td>
        <td><%= link_to 'Destroy', location, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  <% end %>
  </table>
</p>
```

## Add locations to events

Next, we need to actually add a Location to a particular Event.  We can
do so by creating a list of checkboxes that will contain the Locations
to add to the Event when we click the "Update Event" button on the edit
page:

`<td><%= check_box_tag 'add_locations[]', location.id %></td>`

This will not only create a checkbox for each location, but when we
click "Update Event", the id of each selected Location will be passed as
an Array in the update parameters.
